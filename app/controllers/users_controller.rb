class UsersController < ApplicationController
  respond_to :html
  def unsubscribe
    @user = User.find(params[:id])
    
    if params[:confirm].present?
      if params[:secret] == @user.delivery_secret && @user.unsubscribe
        flash[:success] = "You have been successfully unsubscribed from Othermail. Mail received by Othermail will still be saved and you can still access it by emailing check@#{Multiplex::Application::Domain}"
      else
        flash[:error] = "There was an error unsubscribing you! Please try again by clicking one of the links in any of our emails, emailing unsubscribe@#{Multiplex::Application::Domain}, or contacting support at support@#{Multiplex::Application::Domain}."
      end
      redirect_to faq_path
    else
      respond_with @user
    end
  end
end
