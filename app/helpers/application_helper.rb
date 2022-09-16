# frozen_string_literal: true

# Application Helper
module ApplicationHelper
  # def current_order
  #   if session[:order_id].nil?
  #     Order.new
  #   else
  #     @order.find(session[:order_id])
  #   end
  # end

  def sort_list(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction }
  end
end
