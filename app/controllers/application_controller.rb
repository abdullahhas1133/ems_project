# frozen_string_literal: true

# Application_controller
class ApplicationController < ActionController::Base
  # include ApplicationHelper
  protect_from_forgery with: :exception

  private

  def current_cart
    @current_cart = Cart.find_by(user_id: current_user.id)
  end
end
