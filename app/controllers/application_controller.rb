# frozen_string_literal: true

# Application_controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_cart
    @current_cart = current_user.cart
  end

  def current_order
    order = Order.where(user_id: current_user.id).last
    return Order.create(user_id: current_user.id) if order.nil?

    order.status == 'complete' ? Order.create(user_id: current_user.id) : order
  end

  def after_sign_in_path_for(_resource)
    current_user.admin? ? admin_users_path : user_products_path
  end
end
