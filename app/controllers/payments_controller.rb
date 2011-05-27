class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  helper ActiveMerchant::Billing::Integrations::ActionViewHelper

  def new
  end

  def paypal_ipn
    @notify = Paypal::Notification.new(request.raw_post)

    @user = User.find(@notify.item_id)
    @transaction = @user.transactions.build(:notification => @notify)
    if @notify.acknowledge
      begin
        if @notify.complete? and @notify.amount == 8.00
          @transaction.status = 'success'
          @user.enabled = true
        else
          Rails.logger.error("Failed to verify Paypal's notification, please investigate")
        end

      rescue => e
        @transaction.status = 'failed'
        raise
      ensure
        @transaction.save
        @user.save
      end
    else
      Rails.logger.error("Potential hacking attempt!")
    end

    render :nothing => true
  end
end

