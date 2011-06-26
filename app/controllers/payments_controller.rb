class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  helper ActiveMerchant::Billing::Integrations::ActionViewHelper

  def new
  end

  def paypal_ipn
    @notify = Paypal::Notification.new(request.raw_post)
    Transaction.validate!(@notify)
    render :nothing => true
  end
end

