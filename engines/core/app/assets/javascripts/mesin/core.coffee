window.core = {
  onload: ->
    # validate all form if exists
    if $("form").length
      $("form").validate()

    return
}

jQuery -> window.core.onload()
