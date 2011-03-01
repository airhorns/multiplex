class User < ActiveRecord::Base
  def self.available_frequencies
    {:twice_daily => "Twice daily", :daily => "Once a day", :second_day => "Every other day", :weekly => "Once a Week", :never => "Only when I ask"}
  end

  has_many :messages

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :mask_email, :summary_frequency, :password, :password_confirmation, :remember_me
    
  validates_presence_of :email, :mask_email, :summary_frequency
  validates_uniqueness_of :mask_email
  
  # Check for unowned emails
  after_create do 
    Resque.enqueue(CollectUnownedEmailsJob, self.id)
  end

  private
  def password_required? 
    false 
  end
end
