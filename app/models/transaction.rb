class Transaction < ActiveRecord::Base
  include ActiveMerchant::Billing::Integrations
  belongs_to :user
  
  def self.validate!(notify)
    user = User.find(notify.item_id)
    transaction = user.transactions.build(:notification => tnotify)
    if notify.acknowledge
      begin
        if notify.complete? and notify.amount == Money.new(800, 'CAD')
          transaction.status = 'success'
          user.enabled = true
        else
          Rails.logger.error("Failed to verify Paypal's notification, please investigate")
        end

      rescue => e
        transaction.status = 'failed'
        raise
      ensure
        transaction.save
        user.save
      end
    else
      Rails.logger.error("Potential hacking attempt!")
    end
  end

  def paypal_notification
    Paypal::Notification.new(YAML.load(notification).raw)
  end
end 
