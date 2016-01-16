<% if @status.eql? SUCCESS %>
  # destroy tooltip sebelum reload list
  $(".delete-email").tooltip "destroy"

  $("#div_email_settings")
    .empty()
    .append "<%= j render partial: 'list_email'%>"
<% end%>
