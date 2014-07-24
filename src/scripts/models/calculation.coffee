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

  validate: (attrs, opts) ->
    swabErrs = super
    errs = _.omit(swabErrs, 'result') if swabErrs
    errs unless _.isEmpty(errs)

