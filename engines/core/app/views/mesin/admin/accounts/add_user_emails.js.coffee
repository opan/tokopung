<% if @status.eql? SUCCESS %>
  $("#div_email_settings")
    .empty()
    .append "<%= j render partial: 'list_email'%>"
<% end %>
