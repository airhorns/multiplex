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
    faq_path
  end
end
