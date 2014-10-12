ContactManager.module "AboutApp",
  (AboutApp, ContactManager, Backbone, Marionette, $, _) ->
    class AboutApp.Router extends Marionette.AppRouter
      appRoutes:
        "about" : "showAbout"

    API =
      showAbout: ->
        AboutApp.Show.Controller.showAbout()
        ContactManager.execute("set:active:header", "about")

    ContactManager.on "about:show", ->
      ContactManager.navigate("about")
      API.showAbout()

    ContactManager.addInitializer ->
      new AboutApp.Router(controller: API)
