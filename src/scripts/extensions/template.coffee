_.templateSettings =
    evaluate:    /\{\{\{(.+?)\}\}\}/g # {{{ foo = foos.first }}}
    interpolate: /\{\{(.+?)\}\}/g,    # {{ foo.name }}

Backbone.Marionette.Renderer.render = (template, data) ->
  if JST[template]
    _.template(JST[template](), data)
  else
    throw "Template '#{ template }' not found!!"
