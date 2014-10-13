`import template from 'templates/contact/list/item'`

class Contact extends Marionette.ItemView
  tagName: "tr"
  template: template

  triggers:
    "click td a.js-show": "contact:show"
    "click td a.js-edit": "contact:edit"
    "click button.js-delete": "contact:delete"

  events:
    "click": "highlightName"

  flash: (cssClass) ->
    @$el.hide().toggleClass(cssClass).fadeIn 800, =>
      setTimeout((=> @$el.toggleClass(cssClass)), 500)

  highlightName: (e) ->
    @$el.toggleClass("warning")

  remove: ->
    @$el.fadeOut => super

`export default Contact`
