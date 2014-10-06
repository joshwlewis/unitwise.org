class Unitwise.CalculationView extends Marionette.Layout
  template:  'calculation'
  className: 'calculation'

  regions:
    leftContainer:   '.left-container:first'
    rightContainer:  '.right-container:first'
    resultContainer: '.result-container:first'

  modelEvents:
    "change":        "sync"
    "change:left":   "onModelLeftChanged"
    "change:result": "renderResult"

  ui:
    operator: "select[name='operator']:first"

  events:
    'change @ui.operator': 'onUiOperatorChanged'

  initialize: ->
    super
    @depth = @options.depth || 0

  onRender: ->
    @renderLeft()
    @renderOperator()
    @renderRight()

  renderOperator: ->
    @ui.operator.selectize()

  renderLeft: ->
    viewClass = if @depth > 0 then Unitwise.Measurement.Show else Unitwise.Measurement.Edit
    leftView = new viewClass(model: @model.left)
    @leftContainer.show(leftView)

  renderRight: ->
    dim = if _.contains(['convert_to', '+', '-'], @model.get("operator"))
      @model.left.unit.get("dim")
    else
      null

    if @ui.operator.val() == 'convert_to'
      rightView  = new Unitwise.UnitView(model: @model.right.unit, dim: dim)
    else
      rightView  = new Unitwise.Measurement.Edit(model: @model.right, dim: dim)
    @rightContainer.show(rightView)

  renderResult: ->
    @resultModel ||= new Unitwise.Calculation()
    @resultModel.set(left: @model.get("result"))
    @resultView ||= new Unitwise.CalculationView(model: @resultModel, depth: @depth + 1)
    @resultContainer.show(@resultView)

  sync: (model, options) ->
    unless model.changed.result
      @model.save()

  onUiOperatorChanged: (evt) ->
    @model.set(operator: $(evt.target).val())
    @renderRight()

  onModelLeftChanged: (model, value, options) ->
    console.log("model left changed")
    @renderRight() if value.unit
