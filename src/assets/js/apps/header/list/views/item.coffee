class View extends Marionette.ItemView
  template: JST["header/link"]
  tagName: "li"

  events:
    "click a": "navigate"

  navigate: (e) ->
    e.preventDefault()
    this.trigger("navigate", this.model)

  onRender: ->
    if @model.selected
      # add class so Bootstrap will highlight the active entry in the navbar
      @$el.addClass("active")

`export default View`
