class Dashing.Hamotion extends Dashing.Widget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> @_state ? "Unknown"
    set: (key, value) -> @_state = value

  @accessor 'icon',
    get: -> if @get('state') == 'on' then 'exchange' else 'reorder'
    set: Batman.Property.defaultAccessor.set

  @accessor 'icon-style', ->
    if @get('state') == 'on' then 'icon-active' else 'icon-inactive'

  queryState: ->
    $.get '/homeassistant/binarysensor',
      widgetId: @get('id'),
      (data) =>
        json = JSON.parse data
        @set 'state', json.state

  ready: ->
    if @get('bgcolor')
      $(@node).css("background-color", @get('bgcolor'))
    else
      $(@node).css("background-color", "#444")

  onData: (data) ->
