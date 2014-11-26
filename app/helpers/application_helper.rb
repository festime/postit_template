module ApplicationHelper
  def fixed_url(url)
    if url.start_with? 'http://'
      url
    else
      "http://#{url}"
    end
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z") # 03/14/2013 9:09pm UTC
  end
end
