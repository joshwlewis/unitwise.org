class Unitwise.Measurement.Edit extends Marionette.Layout
  template:  'measurement/edit'
  className: 'row'
  regions:
    unitContainer:  '.unit-container:first'

  modelEvents:
    'change:value':  'removeUiError'
    'invalid':       'addUiError'

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
      fn = -> @model.set(value: $(evt.target).val())
      _.throttle(fn, 750))
    @_OnUiValueChanged(evt)

  addUiError: (model, err, opts) ->
    if err.value
      @ui.value.parent().addClass('has-error')

  removeUiError: (model, value, opts) ->
    @ui.value.parent().removeClass('has-error')
