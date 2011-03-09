class UsersController < ApplicationController
  def unsubscribe
    @user = User.find(params[:id])

    if params[:secret] == @user.delivery_secret && @user.unsubscribe
      flash[:success] = "You have been successfully unsubscribed from Otherbox. Mail received by Otherbox will still be saved and you can still access it by emailing check@#{Multiplex::Application::Domain}"
    else
      flash[:error] = "There was an error unsubscribing you! Please try again by clicking the link in all our emails, emailing unsubscribe@#{Multiplex::Application::Domain}, or contacting support at support@#{Multiplex::Application::Domain}."
    end
    redirect_to faq_path
  end
end
