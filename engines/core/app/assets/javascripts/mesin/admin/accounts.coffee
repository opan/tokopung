# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.adm_account = {
  onload: ->
    # override default settings 
    $("#form_profile").data("validator").settings.submitHandler = (form)->
      $.ajax
        url: "/admin/accounts/update_profile"
        method: "put"
        data: $('#form_profile').serialize()
        done: (data)->
          console.log data
        error: (xhr, statusText, errorThrown)->
          console.log statusText  

      return false;


    # datepicker field birthday
    $("#birthdate_input_group").datepicker
      format: "dd MM yyyy"
      autoclose: true
      todayHighlight: true

    return

}


jQuery -> window.adm_account.onload()

