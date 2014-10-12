`import ContactManager from 'app'`

class Model extends Backbone.Model
  initialize: ->
    selectable = new Backbone.Picky.Selectable(@)
    _.extend(@, selectable)


class Collection extends Backbone.Collection
  model: Model

  initialize: ->
    singleSelect = new Backbone.Picky.SingleSelect(@)
    _.extend(@, singleSelect)

headers = null
initializeHeaders = ->
  headers = new Collection [
    { name: "Contacts", url: "contacts", navigationTrigger: "contacts:list" }
    { name: "About", url: "about", navigationTrigger: "about:show" }
  ]

API =
  getHeaders: ->
    if headers? then headers else initializeHeaders()

ContactManager.reqres.setHandler "header:entities", ->
  return API.getHeaders()
