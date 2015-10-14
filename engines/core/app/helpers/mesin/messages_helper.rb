module Mesin
  module MessagesHelper
    def bootstrap_class flash_type
      { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
    end

    def flash_message opts = {}
      
      # if devise_error_messages exists ? 
      if devise_error_messages?
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

      else
        msg_title     = "Please fix some of the errors below :"
        
        flash.each do |msg_type, msg|
          if msg.class.eql? Array
            concat(content_tag(:div, msg, class: "alert #{bootstrap_class(msg_type)} alert-dismissible fade in", role: "alert") do
                concat(content_tag(:button, content_tag(:span, '&times;'.html_safe, "aria-hidden"=> "true"), class: 'close', data: {dismiss: 'alert'}, "aria-label"=>"Close"))
                concat(content_tag(:strong, msg_title))
                concat(content_tag(:ul, msg) do
                  msg.each_with_index do |m,i|
                    concat(content_tag(:li, "#{m}"))
                  end
                end)
              end)
          else
            concat(content_tag(:div, msg, class: "alert #{bootstrap_class(msg_type)} alert-dismissible fade in", role: "alert") do
                concat(content_tag(:button, content_tag(:span, '&times;'.html_safe, "aria-hidden"=> "true"), class: 'close', data: {dismiss: 'alert'}, "aria-label"=>"Close"))
                concat msg
              end)
          end
        end
      end # end devise_error_messages?
      
      nil

    end
  end # end MessageHelper
end # end Mesin
