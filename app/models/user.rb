class User < ActiveRecord::Base
  def self.available_frequencies
    {:twice_daily => "Twice daily", :daily => "One a day", :second_day => "Every other day", :weekly => "Once a Week"}
  end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  private
  def password_required? 
    false 
  end
  
end
