class View extends Marionette.ItemView
  template: JST["contact/show/item"]

  events:
    "click a.js-edit": "editClicked"

  editClicked: (e) ->
    e.preventDefault()
    @trigger("contact:edit", this.model)

`export default View`
