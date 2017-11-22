module OrdersHelper

  def sort_icon
    case params[:sort]
    when "asc"
      link_to icon('sort-asc'), '?sort=desc'
    when "desc"
      link_to icon('sort-desc'), '?sort=asc'
    else
      link_to icon('sort'), '?sort=asc'
    end
  end

end
