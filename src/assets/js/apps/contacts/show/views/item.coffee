`import template from 'templates/contact/show/item'`

class View extends Marionette.ItemView
  template: template

  events:
    "click a.js-edit": "editClicked"

  editClicked: (e) ->
    e.preventDefault()
    @trigger("contact:edit", this.model)

`export default View`
