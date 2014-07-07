Backbone.Marionette.Renderer.render = (template, data) ->
  if JST[template]
    JST[template](data)
  else
    throw "Template '#{ template }' not found!"
