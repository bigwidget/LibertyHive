class UsersController < ApplicationController

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = "fix this"
#   @title = @user.name
  end
  
  def new
    redirect_to(links_path) if user_signed_in?
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html{ render :action => :edit } 
      else
        format.html{ render :action => :new }
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if signed_in?
        flash[:success] = "Profile updated."
        redirect_to @user
      else
        redirect_to about_path
      end
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

end
