class VotesController < ApplicationController

  before_filter :authenticate_user!, :store_referer
  
  def create
    logger.debug "made it to the votes controller"
    @votable = Vote.new(params[:vote]).votable
    current_user.vote_for!(@votable)
  
    if params[:vote][:votable_type] == "Link"
      redirect_back_or links_path  #stay on links page
    else
      redirect_to Link.find(@votable.link_id)   #stay on link discussion page
    end
  end
  
  def destroy
    #currently no way to destroy a vote
  end
  
  private
  
    # do I need this method?
    def find_votable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end  
      return nil
    end


end
