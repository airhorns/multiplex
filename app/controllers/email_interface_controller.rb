class EmailInterfaceController
  class UnrecognizedPathError < StandardError; end
  include ActiveSupport::Callbacks

  @routes = {
    "help"       =>  :send_help,
    "check"       => :send_summary,
    "send"        => :send_summary,
    "unsubscribe" => :unsubscribe
  }
  
  @routes.values.uniq.push(:all).each do |name|
    define_callbacks name, :terminator => "result == false"
  end

  def self.recognize_path(message)
    address = message.mail.to.map{|x| Mail::Address.new(x)}.select{|x| x.domain == Multiplex::Application::Domain}.first
    if address
      @routes[address.local]
    else
     false
    end 
  end
  
  def self.dispatch(message)
    verb = self.recognize_path(message)
    if verb
      i = self.new(message)
      i.run_callbacks :all do
        i.run_callbacks verb do
          i.send(verb)
        end
      end
    else
      raise UnrecognizedPathError.new
    end
  end
 
  set_callback :all, :before do
    unless @message.user.present?
      self.error(:unrecognized_user, message) 
      return false
    end
  end
  
  set_callback :send_summary, :before do
    if !@message.user.confirmed?
      message.user.confirm!
      return true
    end
  end

  attr_accessor :message

  def initialize(msg)
    @message = msg
  end
  
  def send_summary
    Resque.enqueue(MailSummaryJob,@message.user_id)
  end

  def unsubscribe
    @message.user.unsubscribe!
  end
  
  def help
    Resque.enqueue(MailHelpJob,@message.user_id)
  end

  def error(type, message)
    Resque.enqueue(InterfaceErrorNotificationJob, type, message.mail.from)
  end

end
