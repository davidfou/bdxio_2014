`import 'apps/config/marionette/regions/dialog'`

ContactManager = new Marionette.Application()

ContactManager.addRegions
  headerRegion: "#header-region"
  mainRegion: "#main-region"
  dialogRegion: Marionette.Region.Dialog.extend
    el: "#dialog-region"

ContactManager.navigate = (route,  options) ->
  options ?= {}
  Backbone.history.navigate(route, options)

ContactManager.getCurrentRoute = ->
  return Backbone.history.fragment

ContactManager.on "start", ->
  if(Backbone.history)
    Backbone.history.start()
    ContactManager.trigger("contacts:list") if @getCurrentRoute() is ""

`export default ContactManager`
