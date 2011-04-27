class DashboardController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!, :only => :send_summary
    
  layout :set_layout

  def index
    @user = User.new(:summary_frequency => "daily")
    respond_with @user
  end

  def faq
  end

  def learn_more
  end
  
  def send_summary
    current_user.enqueue_summary
    flash[:success] = "Your summary will be sent shortly."
    redirect_to root_path
  end

  private 
  def set_layout
    if [:index, :learn_more].include?(action_name.intern)
      "tagline"
    else
      "application"
    end
  end
end
