class UsersController < ApplicationController

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @link_votes = @user.votes.select {|v| v.votable.class.name == "Link"}
    @activity = !@user.links.empty? || !@user.comments.empty? || !@link_votes.empty?
    @work = @user.profile.occupation.present? || @user.profile.organization.present?
    @any_url = @user.profile.linkedin_url.present? ||
                @user.profile.facebook_url.present? ||
                @user.profile.twitter_url.present? ||
                @user.profile.blog_url.present? ||
                @user.profile.personal_url.present?
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
  
  def edit
    @user = User.find(params[:id])    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
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

  def links
    @user = User.find(params[:id])
    @title = "Links Submitted by #{@user.name}"
    @links = @user.links.paginate(:page => params[:page])
  end
  
  def comments
    @user = User.find(params[:id])
    @title = "Comments by #{@user.name}"
    @comments = @user.comments.paginate(:page => params[:page])
  end
  
  def upvoted
    @user = User.find(params[:id])
    @title = "Links Upvoted by #{@user.name}"
    @all_upvoted_links = @user.votes.collect {|v| v.votable if v.votable_type == "Link"}
    @upvoted_links = @all_upvoted_links.paginate(:page => params[:page])
  end


end
