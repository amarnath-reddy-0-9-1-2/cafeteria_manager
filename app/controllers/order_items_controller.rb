class OrderItemsController < ApplicationController
  # created by cmd
  # rails generate controller OrderItems
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def index
    render plain: OrderItem.all.map { |order| order.to_clear_string }.join("\n")
  end

  def show
    render plain: OrderItem.find(params[:id]).to_clear_string
  end

  def create
    menu_item = MenuItem.find(params[:menu_item_id])
    order = current_user.orders.under_process ? current_user.orders.under_process : Order.create!(user_id: current_user.id)
    order_item = OrderItem.create!(order_id: order.id, menu_item_id: menu_item.id, menu_item_name: menu_item.name, menu_item_price: menu_item.price)
    flash[:notice] = "#{order_item.menu_item_name} is added to cart"
    redirect_to request.referrer
  end

  def destroy
    order_item_id = params[:id]
    order_item = OrderItem.find(order_item_id).destroy
    flash[:notice] = "#{order_item.menu_item_name} is removed from cart"
    redirect_to request.referrer
  end
end
