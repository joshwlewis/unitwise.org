class Unitwise.Calculation extends Unitwise.Model
  urlRoot: 'http://api.unitwise.org/calculations'

  swabs:
    left:   Unitwise.Measurement
    right:  Unitwise.Measurement

  defaults:
    left:     null
    operator: null
    right:    null
    result:   null
