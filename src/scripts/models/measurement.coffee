class Unitwise.Measurement extends Unitwise.Model
  swabs:
    unit: Unitwise.Unit
  defaults:
    value: null
    unit:  null

  validate: (attrs, opts) ->
    errs = super
    unless _.isNumber(parseFloat(attrs?.value))
      errs ||= {}
      errs.value = "must be a number."
    errs
