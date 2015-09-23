module ApplicationHelper
  def flash_class(level)
    case level
    when "notice" then   'alert alert-info'
    when "success" then  'alert alert-success'
    when "error" then    'alert alert-danger'
    when "alert" then    'alert alert-danger'
    end
  end

  def logo
    image_tag('devcon_logo.png', :alt => 'Developers Connect')
  end

  def full_title(page_title)
    base_title = ENV['title']
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def generate_description(text)
    text ||= ""
    text.tr("\n"," ").gsub(/\s+/, " ").strip
  end

  def thumbnail_url(obj)
    thumbnail = (obj.has_attribute?(:thumbnail) ? 
                 obj.thumbnail : obj.logo)
    thumbnail.path == nil ? opengraph_thumb_url : thumbnail.opengraph.url
  end

  def opengraph_thumb_url
    path_to_image("opengraph_default_thumbnail.png")
  end

  def article_opengraph_url(article)
    if article.opengraph_image.nil?
      [opengraph_thumb_url, { :width => 200, :height => 200 }]
    else
      [article.opengraph_image.opengraph.url, { :width => 1200, :height => 630 }]
    end
  end

  def text_field_datetime(datetime)
    l(datetime.nil? ? Time.zone.now : datetime)
  end

end
