# frozen_string_literal: true

# Application_controller
class ApplicationController < ActionController::Base
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email user_name first_name last_name encrypted_password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email user_name first_name last_name encrypted_password])
  end
end
