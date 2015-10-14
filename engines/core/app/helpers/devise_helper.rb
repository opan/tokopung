module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?
    
    title    = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    # messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    concat(content_tag(:div, nil, class: "alert alert-danger alert-dismissible fade in", role: "alert") do
      concat(content_tag(:button, content_tag(:span, '&times;'.html_safe, "aria-hidden"=> "true"), class: 'close', data: {dismiss: 'alert'}, "aria-label"=>"Close"))
      concat(content_tag(:strong, title))
      concat(content_tag(:ul, nil) do
        resource.errors.full_messages.each_with_index do |m,i|
          concat(content_tag(:li, "#{m}"))
        end
      end)
    end)
    # html = <<-HTML
    # <div id="error_explanation">
    #   <h2>#{sentence}</h2>
    #   <ul>#{messages}</ul>
    # </div>
    # HTML

    # html.html_safe
    nil
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
