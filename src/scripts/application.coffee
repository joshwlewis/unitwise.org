Unitwise = new Backbone.Marionette.Application()

Unitwise.addInitializer ->
  @addRegions main: '#main'

Unitwise.addInitializer ->

  class @MeasurementView extends Marionette.ItemView
    template:  'measurement'

  class @UnitView extends Marionette.ItemView
    template:  'unit'

  class @CalculationView extends Marionette.Layout
    template: 'calculation'
    regions:
      leftContainer:   '.left-container'
      rightContainer:  '.right-container'
      resultContainer: '.result-container'

    ui:
      operator: "select[name='operator']"

    events:
      'change @ui.operator': 'renderRight'

    onRender: ->
      @renderLeft()
      @renderRight()

    renderLeft: ->
      leftModel = new Unitwise.Measurement(@model.get('left'))
      leftView = new Unitwise.MeasurementView(model: leftModel)
      @leftContainer.show(leftView)

    renderRight: ->
      if @ui.operator.val() == 'convert'
        rightModel = new Unitwise.Unit(@model.get('right'))
        rightView  = new Unitwise.UnitView(model: rightModel)
      else
        rightModel = new Unitwise.Measurement(@model.get('right'))
        rightView  = new Unitwise.MeasurementView(model: rightModel)
      @rightContainer.show(rightView)


Unitwise.addInitializer ->
  class @Controller extends Marionette.Controller
    show: ->
      model  = new Unitwise.Calculation()
      layout = new Unitwise.CalculationView(model: model)
      Unitwise.main.show(layout)

  @controller = new @Controller()

Unitwise.addInitializer ->
  @router = new Marionette.AppRouter
    controller: @controller
    appRoutes:
      '': 'show'

Unitwise.addInitializer ->
  class @Calculation extends Backbone.Model
    defaults:
      left:     null
      operator: null
      right:    null
      result:   null

  class @Measurement extends Backbone.Model
    defaults:
      name:  null
      value: null

  class @Unit extends Backbone.Model
    defaults:
      name:  null

Unitwise.on "initialize:after", ->
  Backbone.history?.start()

$ -> Unitwise.start()
