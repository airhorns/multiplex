class DashboardController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!, :only => :send_summary

  def index
    @user = User.new(:summary_frequency => "daily")
    @summary_frequencies = User.available_frequencies.collect {|(k,v)| [v,k.to_s]}
    respond_with @user
  end

  def faq
    @user = current_user
  end

  def send_summary
    Resque.enqueue(MailSummaryJob, current_user.id)
    flash[:success] = "Your summary will be sent shortly."
    redirect_to root_path
  end
end
