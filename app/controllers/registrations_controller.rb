# frozen_string_literal: true

# Registration_controller
class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    super
    return unless @user.save

    @cart = Cart.new(user_id: @user.id)
    @cart.save
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email user_name first_name last_name password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email user_name first_name last_name password])
  end
end
