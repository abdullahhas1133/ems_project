# frozen_string_literal: true

# class InvitationsController
class InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[email user_name password])
    devise_parameter_sanitizer.permit(:accept_invitation,
                                      keys: %i[email user_name password first_name last_name])
  end
end
