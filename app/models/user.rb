class User < ActiveRecord::Base
  include DeliverySecret
  def self.available_frequencies
    {:twice_daily => "Twice daily", :daily => "Once a day", :second_day => "Every other day", :weekly => "Once a week", :never => "Only when I ask"}
  end

  has_many :messages
  has_one :invite

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :trackable, :validatable, :confirmable

  attr_accessible :email, :mask_email_name, :summary_frequency, :password, :password_confirmation, :remember_me, :invite_code
    
  validates_presence_of :email, :mask_email_name, :mask_email, :summary_frequency, :invite_code
  validates_uniqueness_of :mask_email

  def unsubscribe!
    self.update_attributes!(:summary_frequency => :never)
    # might need a mailchimp hook here
  end
 
  def unsubscribe
    self.update_attributes(:summary_frequency => :never)
    # might need a mailchimp hook here
  end
  
  def mask_email_name=(name)
    self.mask_email = "#{name}@#{Multiplex::Application::Domain}"
  end
 
  def mask_email_name
    if self.mask_email.present?
      self.mask_email.split("@").first
    else
      nil
    end
  end 

  def available_summary_frequencies
    self.class.available_frequencies
  end

  def enqueue_summary
    Resque.enqueue(MailSummaryJob, self.id)
    true
  end
  
  def invite_code=(code)
    self.invite = Invite.find_by_code(code)
    self.invite_code
  end

  def invite_code
    if self.invite.present?
      self.invite.code
    else
      nil
    end
  end

  private
  def password_required? 
    false 
  end
end
