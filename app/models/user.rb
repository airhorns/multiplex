class User < ActiveRecord::Base
  include DeliverySecret
  def self.available_frequencies
    { 
      #:twice_daily => "Twice daily", 
      :daily => "Once a day", 
      #:second_day => "Every other day", 
      :weekly => "Once a week", 
      :biweekly => "Every two weeks", 
      :never => "Only when I ask"
    }
  end

  has_many :messages
  has_many :transactions
  has_many :delivery_manifests
  has_one :invite
  
  scope :enabled, where(:enabled => true)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :trackable, :validatable, :confirmable

  attr_accessible :email, :mask_email_name, :summary_frequency, :password, :password_confirmation, :remember_me, :invite_code
  attr_accessor :given_invite_code
    
  validates_presence_of :email, :mask_email_name, :mask_email, :summary_frequency
  validates_uniqueness_of :mask_email

  validate :mask_email_valid?
  validate :summary_frequency_valid?
  validate :invite_valid?

  before_create :set_enabled_for_invited

  def unsubscribe!
    self.update_attributes!(:summary_frequency => :never)
    # might need a mailchimp hook here
  end
 
  def unsubscribe
    self.update_attributes(:summary_frequency => :never)
    # might need a mailchimp hook here
  end
  
  def mask_email_name=(name)
    self.mask_email = "#{name.downcase}@#{Multiplex::Application::Domain}"
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
    if self.enabled?
      Resque.enqueue(MailSummaryJob, self.id)
      true
    else
      false
    end
  end
  
  def invite_code=(code)
    self.given_invite_code = code
    self.invite = Invite.find_by_code(code)
    self.invite_code
  end

  def invite_code
    if self.invite.present?
      self.invite.code
    else
      self.given_invite_code
    end
  end

  def enabled?
    self.enabled == true
  end
  
  def mixpanel_attributes
    self.attributes.merge(:ip => self.current_sign_in_ip)
  end

  private
  def password_required? 
    false 
  end

  # Validates inclusion of summary frequency in the available ones for this instance
  def summary_frequency_valid?
    unless self.summary_frequency.present? && available_summary_frequencies.keys.include?(self.summary_frequency.intern)
      errors.add(:summary_frequency, "must be selected from the above options")
    end
  end

  # Validates that the given invite code is good, but doesn't add errors if no invite code is given
  def invite_valid?
    if self.given_invite_code.present?
      if self.invite.present?
        errors.add(:invite_code, "has already been used") if self.invite.used
      else
        errors.add(:invite_code, "must be valid") 
      end    
    end
  end
  
  # Validates that the mask email conforms to our domain and stuff
  def mask_email_valid?
    unless self.mask_email =~ /\A[a-z0-9._%-]+@#{Multiplex::Application::Domain}\z/
      errors.add(:mask_email_name, "must be valid, containing only letters, numbers, and . _ % or -.")
    end
  end

  def set_enabled_for_invited
    if self.valid? && self.invite.present?
      self.enabled = true
    end
  end
end
