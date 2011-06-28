class RegistrationsController < Devise::RegistrationsController
  layout :set_layout

  private 
  def set_layout
    if [:new, :create].include?(action_name.intern)
      "tagline"
    else
      "application"
    end
  end

  def after_sign_up_path_for(resource)
    @mixpanel.track_event("User signed up", resource.mixpanel_attributes)
    if resource.enabled?
      faq_path
    else
      new_payment_path
    end
  end
end
