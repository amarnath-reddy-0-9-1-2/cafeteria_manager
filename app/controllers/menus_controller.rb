class MenusController < ApplicationController
  # created by cmd
  # rails generate controller Menus
  before_action :ensure_owner_logged_in, only: [:create, :destroy, :update]
  def index
    if @current_user.is_owner?
        @menus = Menu.all.order("active DESC NULLS LAST")
    else
       @menus = Menu.marked_as_active
    end
    @order = @current_user.orders.under_process
  end

  def show
  end

  def create
    menu = Menu.create!(name: params[:name].capitalize)
    flash[:notice] = "Menu added succesfully"
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
