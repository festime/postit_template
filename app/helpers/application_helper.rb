module ApplicationHelper
  def fixed_url(url)
    if url.start_with? 'http://'
      url
    else
      "http://#{url}"
    end
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("%m/%d/%Y %l:%M%P %Z") # 03/14/2013 9:09pm EST
  end
end
