class Unitwise.Measurement.Edit extends Marionette.Layout
  template:  'measurement/edit'
  className: 'row'
  regions:
    unitContainer:  '.unit-container:first'

  ui:
    value: "input[name='value']:first"

  onShow: ->
    @renderUnit()

  events:
    "input @ui.value": "onUiValueChanged"

  renderUnit: ->
    unitView = new Unitwise.UnitView(model: @model.unit, dim: @options.dim)
    @unitContainer.show(unitView)

  onUiValueChanged: (evt) ->
    @_OnUiValueChanged ||= (
      fn = -> @model.set(value: $(evt.target).val()) if @valid()
      _.throttle(fn, 750))
    @_OnUiValueChanged(evt)

  valid: ->
    if @ui.value[0].checkValidity()
      @ui.value.parent().removeClass("has-error")
      true
    else
      @ui.value.parent().addClass("has-error")
      false
