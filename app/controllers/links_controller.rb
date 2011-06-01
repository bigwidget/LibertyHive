class LinksController < ApplicationController

  def index
    @title = "Links"
    @links = Link.paginate(:page => params[:page], :per_page => PER_PAGE)
  end
  
  def show
    @link = Link.find(params[:id])
    @title = @link.headline
    @comment = Comment.new
    @root_comments = root_level(@link.comments)
  end
  
  def new
    @link = Link.new
    @title = "Submit a link"
  end
  
  def create
    logger.debug "inside the create method"
    @link = current_user.links.build(params[:link])
    if @link.save
      redirect_to root_path
    else
      @title = "Submit a link"
      render 'new'
    end
  end
  
  def destroy
    @link.destroy
  end
  
  private
  
  def root_level(comments)
    comments.select { |comment| comment.is_root? }
  end

end
