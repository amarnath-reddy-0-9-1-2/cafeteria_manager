class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:create, :new]
  before_action :ensure_owner_logged_in, only: [:index, :clerk, :clerk_update]
  def new
    if current_user
      flash[:notice] = "Your'e already signed up user"
      redirect_to root_path
    end
  end

  def show
    unless current_user
      redirect_to root_path
    end
  end

  def edit

  end

  def index
    @users = User.all
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    if password == password_confirmation
      user = User.new(name: name.capitalize, email: email, role: "customer", password: password)
      if user.save
        session[:current_user_id] = user.id
        redirect_to root_path
      else
        flash[:error] = user.errors.full_messages
        redirect_to new_user_path
      end
    else
      flash[:alert] = "New passwords doesnt match"
      redirect_to new_user_path
    end
  end

  def update
      user = current_user
      password = params[:password]
      password_confirmation = params[:password_confirmation]
      current_password = params[:current_password]
      if user.authenticate(current_password)
        if password == password_confirmation
          flash[:notice] = "Password updated successfully"
          user.update!(password: password)
          redirect_to user_path
        else
          flash[:alert] = "New passwords doesnt match"
          redirect_to edit_user_path
        end
      else
        flash[:alert] = "Your current password is incorrect"
        redirect_to edit_user_path
      end
  end

  def clerk
    name = params[:name]
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    if password == password_confirmation
      user = User.new(name: name.capitalize, email: email, role: "clerk", password: password)
      if user.save
        user.save!
        redirect_to request.referrer
      else
        flash[:error] = user.errors.full_messages
        redirect_to request.referrer
      end
    else
      flash[:alert] = "New passwords doesnt match"
      redirect_to request.referrer
    end
  end

  def clerk_update
    id = params[:id]
    user = User.find(id)
    if user.is_clerk?
      user.role = "customer"
    else
      user.role = "clerk"
    end
    user.save!
    redirect_to request.referrer
  end
end
