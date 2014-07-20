class Unitwise.MeasurementView extends Marionette.Layout
  template:  'measurement'
  className: 'row'
  regions:
    unitContainer:  '.unit-container:first'

  ui:
    value: "input[name='value']:first"

  onShow: ->
    @renderUnit()

  events:
    "input @ui.value": "_onValueChanged"

  renderUnit: ->
    unitView = new Unitwise.UnitView(model: @model.unit, dim: @options.dim)
    @unitContainer.show(unitView)

  _onValueChanged: (evt) ->
    if @valid()
      @model.set(value: $(evt.target).val())

  valid: ->
    if @ui.value[0].checkValidity()
      @ui.value.parent().removeClass("has-error")
      true
    else
      @ui.value.parent().addClass("has-error")
      false
