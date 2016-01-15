window.core = {

  onload: ->
    
    # start jquery.validation rules, methods, options, etc.
    $.validator.setDefaults
      errorPlacement: (error, element)->
        if element.parent(".input-group").length
          error.insertAfter(element.parent())
          
        else
          error.insertAfter(element)

        return
      highlight: (element, errorClass, validClass)->
        $(element).closest(".form-group").addClass("has-error").removeClass("has-success")

        return

      unhighlight: (element, errorClass, validClass)->
        $(element).closest('.form-group').removeClass('has-error').addClass('has-success')

        return

    $("form").each (e)->
      $(@).validate()

    alphanumericonly = (value, element)->
      @.optional element || /^[a-zA-Z0-9]+$/.test(value)
      
    $.validator.addMethod "alphanumericonly", alphanumericonly, 'Letters and numbers only please.'

    numeric = (value, element)->
      @.optional element || /^[0-9]+$/.test(value)

    $.validator.addMethod "numeric", numeric, "Numbers only please."

    commaseparated = (value, element)->
      @.optional element || /^([a-z]+)(,\s*[a-z]+)*$/.test(value)

    $.validator.addMethod "commaseparated", commaseparated, 'Input value separated by commas.'
    # stop jquery.validation rules, methods, options, etc.

    # start setup ajax event
    $(document).on
      ajaxStart: ->
        $("body").addClass "loading"
        return
      ajaxStop: ->
        $("body").removeClass "loading"
        return

    # stop setup ajax event


    # setup tooltip bootstrap
    $("[data-toggle='tooltip']").tooltip()
    return
}

jQuery -> window.core.onload()
