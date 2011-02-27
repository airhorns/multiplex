class DashboardController < ApplicationController
  respond_to :html
  def index
    @user = User.new
    @summary_frequencies = User.available_frequencies.collect {|(k,v)| [v,k]}
    respond_with @user
  end
end
