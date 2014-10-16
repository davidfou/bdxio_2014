`import template from 'templates/header/template'`
`import ItemView from 'apps/header/list/views/item'`

class View extends Marionette.CompositeView
  template: template
  className: "navbar navbar-inverse navbar-fixed-top"
  childView: ItemView
  childViewContainer: "ul"

  events:
    "click a.brand": "brandClicked"

  brandClicked: (e) ->
    e.preventDefault()
    @trigger("brand:clicked")

`export default View`
