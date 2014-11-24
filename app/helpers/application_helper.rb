module ApplicationHelper
  def fixed_url(post)
    if post.url.start_with? 'http://'
      post.url
    else
      "http://#{post.url}"
    end
  end
end
