`import ContactManager from 'app'`
`import Router         from 'apps/about/router'`
`import ShowController from 'apps/about/show/controller'`

API =
  showAbout: ->
    ShowController.showAbout()
    ContactManager.execute("set:active:header", "about")

ContactManager.on "about:show", ->
  ContactManager.navigate("about")
  API.showAbout()

ContactManager.addInitializer ->
  new Router(controller: API)
