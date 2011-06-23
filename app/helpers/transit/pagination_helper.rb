module Transit::PaginationHelper
  unloadable
  
  def paginate(collection, html_attrs = {})    
    return "" if collection.total_count <= 0
    
    total_pages  = collection.total_pages
    current_page = collection.current_page
    html_classes = (html_attrs.delete(:class) || "").split(" ")
    window_min   = [(current_page - 5), 1].max
    window_max   = [(current_page + 5), total_pages].min
    page_links   = []
    
    html_attrs.merge!('class' => html_classes.push('pagination_link').uniq.join(" "))
    
    (window_min..window_max).to_a.each do |page|
      unless page == current_page        
        page_links << pagination_link(page, html_attrs)
      else
        page_links << content_tag(:span, page, class: 'current').to_s
      end
    end
    
    unless current_page == 1
      page_links.unshift pagination_link_previous(current_page - 1, html_attrs).html_safe
    end
    unless current_page == total_pages
      page_links << pagination_link_next(current_page + 1, total_pages, html_attrs).html_safe
    end
    
    content_tag(:p, class: 'pagination') do
      content_tag(:span, "Viewing page #{current_page} of #{total_pages}", class: 'pagination_detail') <<
      content_tag(:span, page_links.join(" ").html_safe, class: 'pagination_links')
    end.html_safe

  end
  
  private 
  
  def pagination_link_previous(prev_page, attrs)
    pagination_link(1, attrs, "&lArr;") <<
    pagination_link(prev_page, attrs, "&laquo;")
  end
  
  def pagination_link_next(next_page, last_page, attrs)
    pagination_link(next_page, attrs, "&raquo;") <<
    pagination_link(last_page, attrs, "&rArr;")
  end
  
  def pagination_link(page, attrs, text = nil)
    text ||= page
    qstring  = CGI.parse(request.query_string).merge('page' => page )
    link_to(text.to_s.html_safe, "?#{qstring.to_query}", attrs).html_safe.to_s
  end
  
end