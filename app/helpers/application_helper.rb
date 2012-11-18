module ApplicationHelper
  include SessionsHelper
  def full_title(page_title)
    base_title = ""
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def google_search(query)
    "http://www.google.com/search?q=#{query}&sugexp=chrome,mod=0&sourceid=chrome&ie=UTF-8"
  end

  def youtube_link(id, vid)
    "<iframe id=\"#{id}\" type=\"text/html\" width=\"200\" height=\"200\"
     src=\"http://www.youtube.com/embed/#{vid}?enablejsapi=1&frameborder=\"0\">
     </iframe>"
  end
 
end
