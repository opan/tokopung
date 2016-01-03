# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.adm_account = {
  onload: ->
    $("#form_profile").submit (e)->
      console.log "masuk"
      return false;

    $("#birthdate_input_group").datepicker
      format: "dd MM yyyy"
      autoclose: true
      todayHighlight: true
      

    return

}


jQuery -> window.adm_account.onload()

