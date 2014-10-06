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
        options:     Unitwise.units.withDim(@options.dim),
        selectOnTab: true
        load: (query, callback) =>
          new Unitwise.Units().fetch
            data: { q: query }
            success: (collection) =>
              console.log(@, @options)
              callback(collection.withDim(@options.dim))
      @selectize = @ui.code[0].selectize
      @listenTo @selectize, 'item_add', @onItemSelected
      @listenTo @selectize, 'item_remove', @onItemDeselected

  updateOptions: ->
    selectize = @ui.code[0].selectize
    Unitwise.units.withDim(@options.dim).forEach (opt) ->
      selectize.addOption(opt)
    selectize.refreshOptions(false)


  onItemSelected: (val) =>
    unit = new Unitwise.Unit(code: val)
    unit.fetch().always =>
        @model.set(_.clone(unit.attributes))

  onItemDeselected: =>
    @model.clear()

  selectCode: ->
    if (val = @model.get "code") != @selectize.getValue()
      @selectize.setValue(val)

  addUiError: (model, error, options) ->
    if error.code
      @ui.code.parent().addClass('has-error')

  removeUiError: (model, value, options) ->
    @ui.code.parent().removeClass('has-error')


