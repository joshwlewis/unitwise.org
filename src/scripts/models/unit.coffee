class Unitwise.Unit extends Unitwise.Model
  defaults:
    code:        null
    name:        null
    symbol:      null
    description: null
    dim:         null

  # Add a handy description
  parse: (attrs) ->
    attrs.description = @getDescription(attrs)
    attrs

  getDescription: (attrs) ->
    attrs = attrs || @attributes
    aliases = _([attrs.code, attrs.symbol]).compact().uniq().join(", ")
    "#{attrs.name} (#{aliases})"

