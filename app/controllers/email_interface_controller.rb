class EmailInterfaceController
  @routes = {
    "check"       => :send_summary,
    "send"        => :send_summary,
    "unsubscribe" => :unsubscribe
  }

  def self.recognize_path(message)
    address = message.mail.to.map{|x| Mail::Address.new(x)}.select{|x| x.domain == Multiplex::Application::Domain}.first
    if address
      @routes[address.local]
    else
     false
    end 
  end
  
  def self.dispatch(message)
    self.new(message).send(self.recognize_path(message))
  end
  
  attr_accessor :message

  def initialize(msg)
    @message = msg
  end

  def send_summary
    if @message.user.present?
      Resque.enqueue(MailSummaryJob,@message.user_id)
    else
      self.error(:unrecognized_user, @message) 
    end
  end

  def unsubscribe
    if @message.user.present?
      @message.user.unsubscribe!
    else
      self.error(:unrecognized_user, @message)      
    end
  end

  def error(type, message)
    Resque.enqueue(InterfaceErrorNotificationJob, type)
  end
end
