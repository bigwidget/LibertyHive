class PagesController < ApplicationController

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
  
  def links
    @title = "Links"
    @links = Link.all
  end

end
