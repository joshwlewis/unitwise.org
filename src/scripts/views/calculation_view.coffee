class Unitwise.CalculationView extends Marionette.Layout
  template:  'calculation'

  regions:
    leftContainer:   '.left-container:first'
    rightContainer:  '.right-container:first'
    resultContainer: '.result-container:first'

  modelEvents:
    "change": "save"

  ui:
    operator: "select[name='operator']:first"

  events:
    'change @ui.operator': 'onUiOperatorChanged'

  onRender: ->
    @renderLeft()
    @renderOperator()
    @renderRight()

  renderOperator: ->
    @ui.operator.selectize()

  renderLeft: ->
    leftView = new Unitwise.MeasurementView(model: @model.left)
    @leftContainer.show(leftView)

  renderRight: ->
    dim = if _.contains(['convert_to', '+', '-'], @model.get("operator"))
      @model.left.unit.get("dim")
    else
      null

    if @ui.operator.val() == 'convert_to'
      rightView  = new Unitwise.UnitView(model: @model.right.unit, dim: dim)
    else
      rightView  = new Unitwise.MeasurementView(model: @model.right, dim: dim)
    @rightContainer.show(rightView)

  renderResult: ->
    newCalc = new Unitwise.Calculation(left: _.clone(@model.get 'result'))
    view = new Unitwise.CalculationView(model: newCalc)
    @resultContainer.show(view)

  save: (model, options) ->
    unless model.changed.result
      @model.save()
        .success => @renderResult()

  onUiOperatorChanged: (evt) ->
    @model.set(operator: $(evt.target).val())
    @renderRight()
