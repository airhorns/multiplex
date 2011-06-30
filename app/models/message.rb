#encoding: utf-8
require 'digest/sha1'

class Message < ActiveRecord::Base
  include DeliverySecret

  class << self
   def message_from_cloudmailin(params)
     Mail.new(params[:message])
   end

   def message_from_sendgrid(params)
      # Sendgrid auto-decodes the headers into UTF8
      mail = Mail.new(params[:headers])

      if params[:text].present?
        text_body = params[:text]
        mail.text_part = Mail::Part.new(:charset => 'UTF-8', :content_type => "text/plain;", :body => text_body)
      end

      if params[:html].present?
        html_body = params[:html]
        mail.html_part = Mail::Part.new(:charset => 'UTF-8', :content_type => "text/html;", :body => html_body)
      end
      mail
    end

    def new_from_mail(mail)
      attributes = {}
      ['to', 'from'].each do |sym|
        attributes[(sym+'_email').intern]   = mail[sym.intern].addresses.join(", ")
        attributes[(sym+'_name').intern]    = mail[sym.intern].display_names.join(", ")
      end

      attributes[:subject]      = mail.subject
      attributes[:delivered]    = false
      attributes[:user]         = User.find_by_mask_email(attributes[:to_email]) || User.find_by_email(attributes[:from_email])
      self.new(attributes)
    end

    def new_from_params(params, type)
      params = send("prepare_#{type}_params", params)
      mail = self.send("message_from_#{type}", params)
      message = self.new_from_mail(mail)
      message.params_type = type
      message.params = YAML.dump(params)
      message
    end

    private
    def prepare_sendgrid_params(params)
      # Sendgrid auto-decodes the headers into UTF8
      new = {:headers => params[:headers]}
      encodings = ActiveSupport::JSON.decode(params[:charsets])
      encodings.each do |key, encoding|
        new[key.intern] = params[key].force_encoding(encodings[key]).encode("UTF-8") if params[key].present?
      end
      new
    end

    def prepare_cloudmailin_params(params)
      # Don't need the rest of the stuff
      new = {:message => params[:message]}
      new
    end
    
  end

  attr_accessor :mail

  belongs_to :user
  has_many :manifest_entries 
  has_many :delivery_manifests, :through => :manifest_entries

  scope :undelivered, self.scoped.where(:delivered => false)
  scope :unsummarized, self.scoped.where(:summarized => false)
  scope :delivered, self.scoped.where(:delivered => true)
  scope :summarized, self.scoped.where(:summarized => true)
 
  before_create :set_delivery_secret

  validates_presence_of :subject, :mail

  def to
    "#{self.to_email} - #{self.to_name}"
  end

  def from
    "#{self.from_email} - #{self.from_name}"
  end

  def mail
    unless @mail.present?
      @mail = self.class.send("message_from_#{self.params_type}", YAML.load(self.params))
    end
    @mail
  end

  def queue_delivery
    Resque.enqueue(MailMessageJob, self.id) if !self.delivered
  end

  def deliver!
    outgoing = self.deliverable
    outgoing.deliver!
    if self.delivered == false
      self.update_attributes!(:delivered => true)
    end
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
