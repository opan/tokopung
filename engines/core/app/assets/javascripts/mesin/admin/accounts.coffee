# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.adm_account = {
  onload: ->
    # untuk tooltip email
    $("#div_email_settings").tooltip
      selector: ".delete-email"

    # datepicker field birthday
    $("#birthdate_input_group").datepicker
      format: "dd MM yyyy"
      autoclose: true
      todayHighlight: true


    $(document).on "click", ".delete-email", (e)->
      email_id = $(@).data "email-id"
      $.ajax
        url: "/admin/accounts/#{email_id}/change_user_emails"
        type: "delete"
        dataType: "script"
      return
      
    return
}


jQuery -> window.adm_account.onload()

