class MessagesController < ApplicationController
  respond_to :html
  skip_before_filter :verify_authenticity_token
  
  def sendgrid_create
    create(:sendgrid)
  end

  def cloudmailin_create
    create(:cloudmailin)
  end
  
  def deliver
    @message = Message.find(params[:id])
    if @message.delivery_secret == params[:secret]
      @message.queue_delivery
      render 'delivery_manifests/autoclose'
      return
    else
      flash[:error] = "Error delivering message."
    end
    redirect_to faq_path
  end

  private
  def create(type)
    @message = Message.new_from_params(params, type)
    if EmailInterfaceController.recognize_path(@message)
      EmailInterfaceController.dispatch(@message)
    else
      @message.save!
    end
    render :nothing => true, :status => 200 # a status of 404 would reject the mail
  end
end
