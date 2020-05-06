class MenusController < ApplicationController
  # created by cmd
  # rails generate controller Menus

  def index
    if @current_user.role == "owner"
        @menus = Menu.all.order(:active)
    else
       @menus = Menu.marked_as_active
    end
    @order = current_user.orders.under_process
  end

  def show
  end

  def create
    menu = Menu.create!(name: params[:name].capitalize)
    render plain: "created #{menu.name} with #{menu.id}"
  end

  def update
    ensure_owner_logged_in
    Menu.all.map { |menu| menu.update(active: nil) }
    menu = Menu.find(params[:id])
    menu.active = params[:active]
    menu.save!
    redirect_to menus_path
  end

  def destroy
    ensure_owner_logged_in
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to menus_path
  end
end
