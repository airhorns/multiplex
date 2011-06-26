class Transaction < ActiveRecord::Base
  include ActiveMerchant::Billing::Integrations
  belongs_to :user

  def paypal_notification
    Paypal::Notification.new(YAML.load(notification.raw))
  end
end 
