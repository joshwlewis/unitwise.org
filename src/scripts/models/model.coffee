class Unitwise.Model extends Backbone.Model
  baws:     null
  swabs:    {}

  constructor: (attrs, opts) ->
    super
    @throttledSet = _.throttle(@set, 500)

  initialize: (attrs, opts) ->
    @baws = opts?.baws
    for swab_key, swab_klass of @swabs
      attrs ||= {}
      this[swab_key] = new swab_klass(_.clone(attrs[swab_key]), baws: this)

  set: (attrs, opts) ->
    if opts?.belay
      super
    else
      @setSwabs(attrs)
      @setBaws()

  setBaws: ->
    if @baws
      for swab_key of @baws.swabs when @baws[swab_key] == this
        attrs = {}
        attrs[swab_key] = _.clone(@attributes)
        @baws.set(attrs, belay: true)
        @baws.setBaws()

  setSwabs: (attrs) ->
    @set(attrs, belay: true)
    for key, value of attrs when key of @swabs
      this[key]?.setSwabs(_.clone(value))

  validate: (attrs, opts) ->
    errs = null
    for key, value of attrs when key of @swabs
      unless _.isObject(value)
        errs ||= {}
        errs[key] = 'is required.'
      else unless this[key]?.isValid()
        errs ||= {}
        errs[key] = this[key].validationError
    errs


