require 'digest/sha1'

class Message < ActiveRecord::Base
  include DeliverySecret

  class << self
   def message_from_cloudmailin(params)
     Mail.new(params[:message])
   end

   def message_from_sendgrid(params)
      encodings = ActiveSupport::JSON.decode(params[:charsets])
      # Sendgrid auto-decodes the headers into UTF8
      mail = Mail.new(params[:headers])

      if params[:text].present?
        text_body = params['text'].force_encoding(encodings['text']).encode("UTF-8")
        mail.text_part = Mail::Part.new(:charset => 'UTF-8', :content_type => "text/plain;", :body => text_body)
      end

      if params[:html].present?
        html_body = params['html'].force_encoding(encodings['html']).encode("UTF-8")
        mail.html_part = Mail::Part.new(:charset => 'UTF-8', :content_type => "text/html;", :body => html_body)
      end
      debugger 
      mail
    end

    def new_from_mail(mail)
      attributes = {}
      ['to', 'from'].each do |sym|
        attributes[(sym+'_email').intern]   = mail[sym.intern].addresses.join(", ")
        attributes[(sym+'_name').intern]    = mail[sym.intern].display_names.join(", ")
      end

      # Incoming mail. To Us, from Them
      attributes[:subject]      = mail.subject
      attributes[:delivered]    = false
      attributes[:user]         = User.find_by_mask_email(attributes[:to_email])
      self.new(attributes)
    end

    def new_from_params(params, type)
      mail = self.send("message_from_#{type}", params)
      message = self.new_from_mail(mail)
      message.params_type = type
      message.params = "#{Marshal.dump(params)}".encode("UTF-8")
      message
    end
  end

  belongs_to :user
  validates_presence_of :subject, :mail

  scope :undelivered, self.scoped.where(:delivered => false)
  scope :delivered, self.scoped.where(:delivered => true)
  before_create :set_delivery_secret

  def to
    "#{self.to_email} - #{self.to_name}"
  end

  def from
    "#{self.from_email} - #{self.from_name}"
  end

  def mail
    unless @mail_obj.present?
      @mail_obj = self.class.send("message_from_#{self.params_type}", Marshal.load(self.params))
    end
    @mail_obj
  end

  def queue_delivery
    Resque.enqueue(MailMessageJob, self.id) if !self.delivered
  end

  def deliver!
    outgoing = self.deliverable
    outgoing.deliver!
    self.delivered = true
    self.save!
  end

  def deliverable
    incoming = self
    outgoing = Mail.new do
      from incoming.mail.header[:from]
      reply_to incoming.mail.header[:reply_to]
      to incoming.user.email
      subject incoming.mail.header[:subject]
    end

    if incoming.mail.text_part
      text_part = Mail::Part.new do
        content_type 'text/plain; charset=UTF-8'
        body incoming.mail.text_part.decoded
      end
      outgoing.text_part = text_part
    end

    if incoming.mail.html_part
      html_part = Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body incoming.mail.html_part.decoded
      end
      outgoing.html_part = html_part
    end
    outgoing
  end
end
