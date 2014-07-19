class Unitwise.Units extends Backbone.Collection
  url: '//api.unitwise.org/units'
  model: Unitwise.Unit
  selectOptionsData: ->
    console.log @length
    if @length
      @map (u) ->
        value: u.get("code")
        label: "#{ u.get('name') } (#{ u.get('aliases').join(', ') })"
    else
      []

