(($) ->

  $.fn.down = ->
    el = @[0] and @[0].firstChild
    while el and el.nodeType != 1
      el = el.nextSibling
    $ el

  return
) jQuery
