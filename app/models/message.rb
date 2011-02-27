require 'mail'

class Message < ActiveRecord::Base
 belongs_to :user
 validates_presence_of :subject, :mail

 class << self
   def message_from_cloudmailin(params)
     Mail.new(params[:message])
   end

   def message_from_sendgrid(params)
      require 'iconv'
      encodings = ActiveSupport::JSON.decode(params[:charsets])
      # Sendgrid auto-decodes the headers into UTF8
      mail = Mail.new(params[:headers])
      mail.text_part = Mail::Part.new(:charset => 'UTF-8', :content_type => "text/plain;", :body => Iconv.conv(encodings['text']+"//IGNORE", 'UTF-8', params[:text])) if params[:text].present?
      mail.html_part = Mail::Part.new(:charset => 'UTF-8', :content_type => "text/html;", :body => Iconv.conv(encodings['html']+"//IGNORE", 'UTF-8', params[:html])) if params[:html].present?
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
      message.params = Marshal.dump(params)
      message
    end
  end
  
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

end
