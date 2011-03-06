class DashboardController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!, :only => :send_summary

  def index
    @user = User.new(:summary_frequency => "daily")
    respond_with @user
  end

  def faq
  end
  
  def send_summary
    Resque.enqueue(MailSummaryJob, current_user.id)
    flash[:success] = "Your summary will be sent shortly."
    redirect_to root_path
  end
end
