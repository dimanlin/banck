class ConfirmationsController < Devise::ConfirmationsController

  protected

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      "#{Rails.configuration.application.frontend}/sign_in"
    end
  end

end