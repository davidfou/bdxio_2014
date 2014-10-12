ContactManager.module "AboutApp.Show",
  (Show, ContactManager, Backbone, Marionette, $, _) ->
    class Show.Message extends Marionette.ItemView
      template: JST["about/message"]
