class Unitwise.Units extends Backbone.Collection
  url: '//api.unitwise.org/units'
  model: Unitwise.Unit

  # Returns array of attributes for selectize
  withDim: (dim) ->
    if _.isString(dim)
      _.map(@where(dim: dim), (u) -> u.attributes)
    else
      @toJSON()
