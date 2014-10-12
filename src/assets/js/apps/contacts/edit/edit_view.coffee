ContactManager.module "ContactsApp.Edit",
  (Edit, ContactManager, Backbone, Marionette, $, _) ->
    class Edit.Contact extends ContactManager.ContactsApp.Common.Views.Form
      initialize: ->
        @title = "Edit #{@model.get("firstName")} #{@model.get("lastName")}"

      onRender: ->
        if @options.generateTitle
          $title = $('<h1>', text: this.title)
          @$el.prepend($title)

        @$(".js-submit").text("Update contact")
