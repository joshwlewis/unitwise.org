class Unitwise.CalculationView extends Marionette.Layout
  template:  'calculation'

  regions:
    leftContainer:   '.left-container'
    rightContainer:  '.right-container'
    resultContainer: '.result-container'

  modelEvents:
    "change": "save"

  ui:
    operator: "select[name='operator']"

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
    if @ui.operator.val() == 'convert_to'
      rightView  = new Unitwise.UnitView(model: @model.right.unit)
    else
      rightView  = new Unitwise.MeasurementView(model: @model.right)
    @rightContainer.show(rightView)

  renderResult: ->
    newCalc = new Unitwise.Calculation(left: _.clone(@model.get 'result'))
    view = new Unitwise.CalculationView(model: newCalc)
    @resultContainer.show(view)

  save: (args) ->
    @model.save()
      .success => @renderResult()

  onUiOperatorChanged: (evt) ->
    @model.set(operator: $(evt.target).val())
    @renderRight()
