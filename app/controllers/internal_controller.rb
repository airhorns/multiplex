class InternalController < ApplicationController
  PASSWORD = "5ky11ght"
 
  before_filter :authenticate
 
  private
 
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      password == PASSWORD
    end
  end
  
end
