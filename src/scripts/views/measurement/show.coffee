class Unitwise.Measurement.Show extends Marionette.Layout
  template:  'measurement/show'
  className: 'row'
  templateHelpers: =>
    value:       parseFloat(@model.get "value")
    description: @model.unit.getDescription()
