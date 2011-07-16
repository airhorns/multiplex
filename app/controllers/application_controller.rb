class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_mixpanel

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      faq_path
    else
      super
    end
  end

  def initialize_mixpanel
    @mixpanel = Mixpanel::Tracker.new(Multiplex::Application::MixpanelKey, request.env, true)
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
end
