Unitwise = new Backbone.Marionette.Application()

Unitwise.addInitializer ->
  @addRegions main: '#main'

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


Unitwise.on "initialize:after", ->
  Unitwise.units = new Unitwise.Units()
  Unitwise.units.fetch success: -> Unitwise.vent.trigger "units:updated"
  Backbone.history?.start()

$ -> Unitwise.start()
