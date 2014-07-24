class Unitwise.UnitView extends Marionette.ItemView
  template:  'unit'
  ui:
    code: "select[name='code']:first"

  modelEvents:
    "change:code": "selectCode removeUiError"
    "invalid":     "addUiError"

  onRender: ->
    @initSelectize()
    @selectCode()
    @listenTo Unitwise.vent, "units:updated", @updateOptions

  initSelectize: ->
    unless @selectize
      @ui.code.selectize
        valueField:  'code'
        labelField:  'description'
        searchField: ['name','code','symbol']
        options:     Unitwise.units.withDim(@options.dim)
      @selectize = @ui.code[0].selectize
      @listenTo @selectize, 'change', @onUiCodeChange

  updateOptions: ->
    selectize = @ui.code[0].selectize
    Unitwise.units.withDim(@options.dim).forEach (opt) ->
      selectize.addOption(opt)
    selectize.refreshOptions(false)

  onUiCodeChange: (val) =>
    if unit = Unitwise.units.findWhere(code: val)
      @model.set(_.clone(unit.attributes))
    else
      @model.clear()

  selectCode: ->
    if (val = @model.get "code") != @selectize.getValue()
      @selectize.setValue(val)

  addUiError: (model, error, options) ->
    if error.code
      @ui.code.parent().addClass('has-error')

  removeUiError: (model, value, options) ->
    @ui.code.parent().removeClass('has-error')


