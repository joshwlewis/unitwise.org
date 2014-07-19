class Unitwise.MeasurementView extends Marionette.Layout
  template:  'measurement'
  regions:
    unitContainer:  '.unit-container'

  ui:
    value: "input[name='value']"

  onShow: ->
    @renderUnit()

  events:
    "input @ui.value": "_onValueChanged"

  renderUnit: ->
    unitView = new Unitwise.UnitView(model: @model.unit)
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
