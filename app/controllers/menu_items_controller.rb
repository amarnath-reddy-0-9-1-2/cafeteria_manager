class MenuItemsController < ApplicationController
  # created by cmd
  # rails generate controller MenuItems
  before_action :ensure_owner_logged_in, only: [:create, :destroy, :edit, :update, :activate]

  def index
  end

  def show
  end

  def create
    if params[:id]
     menu = params[:id] == "0" ? Menu.new(name: params[:new_menu_name].capitalize) : Menu.find(params[:id])
     menu.save
     menu_item = MenuItem.new(name: params[:name].capitalize, description: params[:description].capitalize, menu_id: menu.id, price: params[:price])
     if menu.save && menu_item.save
       flash[:alert] = "Item added successfully!"
     else
       flash[:error] = menu_item.errors.full_messages + menu.errors.full_messages
     end
    else
     flash[:alert] = "Please select a menu name"
    end
     redirect_to menus_path
  end

  def destroy
    MenuItem.find(params[:id]).destroy
    redirect_to menus_path
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    menu_item = MenuItem.find(params[:id])
    menu_item.name = params[:name].capitalize
    menu_item.description = params[:description].capitalize
    menu_item.price = params[:price]
    if menu_item.save
      flash[:notice] = "Item updated successfully!"
      redirect_to menus_path
    else
      flash[:error] = menu_item.errors.full_messages
      redirect_to edit_menu_item_path
    end
  end

  def activate
    id = params[:id]
    active = params[:active]
    menu_item = MenuItem.find(id)
    menu_item.active = active
    menu_item.save!
    Order.under_process.destroy_all
    redirect_to menus_path
  end

  private

  def permit_params
    params.require(:menu_item).pemit(:name, :description, :menu_name, :price)
  end
end
