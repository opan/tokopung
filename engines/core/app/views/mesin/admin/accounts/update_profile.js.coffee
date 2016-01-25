<% if @status.eql? SUCCESS %>
  $("#div_email_settings")
    .empty()
    .append "<%= j render partial: 'list_email'%>"

  $("#username_navbar").text "Hi, <%= current_user.profile.username %>"
<% end %>
