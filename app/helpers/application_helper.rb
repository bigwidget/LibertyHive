module ApplicationHelper

  def base_rank
     @page_num = params[:page] ? params[:page].to_i : 1
     @base_rank = (@page_num - 1) * PER_PAGE
  end
    
end
