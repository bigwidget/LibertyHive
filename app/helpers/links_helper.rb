module LinksHelper

  def discussion_link(link)
    text = link.comments.empty? ? "discuss" : pluralize(link.comments.count, "comment")
    return link_to(text, link)
  end

end
