class MessagesController < ApplicationController
  respond_to :html
  skip_before_filter :verify_authenticity_token
  
  def index
    @messages = Message.all
    respond_with @messages
  end

  def show
    @message = Message.find(params[:id])
    respond_with @message
  end

  def sendgrid_create
    @message = Message.new_from_params(params, :sendgrid).save!
    render :nothing => true, :status => 200 # a status of 404 would reject the mail
  end

  def cloudmailin_create
    @message = Message.new_from_params(params, :cloudmailin).save!
    render :nothing => true, :status => 200 # a status of 404 would reject the mail
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to(messages_url)
  end
end
