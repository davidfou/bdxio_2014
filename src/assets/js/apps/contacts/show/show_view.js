ContactManager.module("ContactsApp.Show", function(Show, ContactManager, Backbone, Marionette, $, _){
  Show.MissingContact = Marionette.ItemView.extend({
    template: JST["contact/show/missing"]
  });

  Show.Contact = Marionette.ItemView.extend({
    template: JST["contact/show/item"],

    events: {
      "click a.js-edit": "editClicked"
    },

    editClicked: function(e){
      e.preventDefault();
      this.trigger("contact:edit", this.model);
    }
  });
});
