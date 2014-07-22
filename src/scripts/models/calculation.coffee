class Unitwise.Calculation extends Unitwise.Model
  urlRoot: 'http://api.unitwise.org/calculations'

  swabs:
    left:   Unitwise.Measurement
    right:  Unitwise.Measurement
    result: Unitwise.Measurement

  defaults:
    left:     null
    operator: 'convert_to'
    right:    null
    result:   null
