class OrdersController < ApplicationController
  # created by cmd
  # rails generate controller Orders

  def index
    orders = current_user.orders.order(:id)
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    if @user.id == @current_user.id
    else
      ensure_owner_logged_in
    end
  end

  def pending_orders
    ensure_owner_or_clerk_logged_in
  end

  def create
    @order = current_user.orders.under_process.first
    if @order.order_items.empty?
      redirect_to(cart_path, alert: "Order must have atleast 1 item")
    else
      @order.status = "order_confirmed"
      @order.address = params[:address]
      @order.ordered_at = Time.now + 19800
      @order.save!
      flash[:notice] = "Order recived! Soon your order will be delivered"
      redirect_to orders_path
    end
  end

  def update
    ensure_owner_or_clerk_logged_in
    @order = Order.find(params[:id])
    @order.status = "order_delivered"
    @order.delivered_at = Time.now + 19800
    @order.date = Date.today
    @order.save!
    flash[:notice] = "#{@order.id} is marked as delivered!"
    redirect_to "/pending_orders"
  end

  def cart
    @order = current_user.orders.under_process.first
  end

  def all_orders
    ensure_owner_logged_in
    @all_orders = Order.order(id: :desc)
  end

  def rating
    @order = Order.find(params[:id])
    @order.ratings = params[:rating]
    @order.save!
    @order.order_items.rate_menu_items(params[:rating])
    flash[:notice] = "Thank you for rating order"
    redirect_to request.referrer
  end

  def destroy
    order = Order.find(params[:id])
    if order.user_id == @current_user.id
      order.destroy
      flash[:notice] = "Order deleted sucessfully"
    else
      flash[:alert] = "you are not allowed to do that"
    end
    redirect_to request.referrer
  end

  def report
    ensure_owner_logged_in
    @users = User.all
    @orders = Order.completed
    @menus = Menu.all
    @menu_items = MenuItem.all
  end

  def date_wise_report
    ensure_owner_logged_in
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    if @start_date == nil || @end_date == nil
      flash[:alert] = "enter the dates"
    else
    @customers = User.customers
    @clerks = User.clerks
    @orders = Order.completed.get_orders_between(@start_date, @end_date)
    @menus = Menu.all
    @menu_items = MenuItem.all
    @owner = User.where("role = ?", "owner")
    end
  end
end
