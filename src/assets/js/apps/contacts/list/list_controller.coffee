ContactManager.module "ContactsApp.List",
  (List, ContactManager, Backbone, Marionette, $, _) ->
    List.Controller =
      listContacts: (criterion) ->
        loadingView = new ContactManager.Common.Views.Loading()
        ContactManager.mainRegion.show(loadingView)

        fetchingContacts = ContactManager.request("contact:entities")

        contactsListLayout = new List.Layout()
        contactsListPanel = new List.Panel()

        $.when(fetchingContacts).done (contacts) ->
          filteredContacts = ContactManager.Entities.FilteredCollection
            collection: contacts
            filterFunction: (filterCriterion) ->
              filterCriterion = filterCriterion.toLowerCase()
              filter = (contact) ->
                if contact.get("firstName").toLowerCase().indexOf(filterCriterion) isnt -1 or \
                contact.get("lastName").toLowerCase().indexOf(filterCriterion) isnt -1 or \
                contact.get("phoneNumber").toLowerCase().indexOf(filterCriterion) isnt -1
                  return contact

          if criterion
            filteredContacts.filter(criterion)
            contactsListPanel.once "show", ->
              contactsListPanel.triggerMethod("set:filter:criterion", criterion)

          contactsListView = new List.Contacts(collection: filteredContacts)

          contactsListPanel.on "contacts:filter", (filterCriterion) ->
            filteredContacts.filter(filterCriterion)
            ContactManager.trigger("contacts:filter", filterCriterion)

          contactsListLayout.on "show", ->
            contactsListLayout.panelRegion.show(contactsListPanel)
            contactsListLayout.contactsRegion.show(contactsListView)

          contactsListPanel.on "contact:new", ->
            newContact = new ContactManager.Entities.Contact()

            view = new ContactManager.ContactsApp.New.Contact(model: newContact)

            view.on "form:submit", (data) ->
              if contacts.length > 0
                highestId = contacts.max((c) -> c.id).get("id")
                data.id = highestId + 1
              else
                data.id = 1

              if newContact.save(data)
                contacts.add(newContact)
                view.trigger("dialog:close")
                newContactView = contactsListView.children.findByModel(newContact)
                # check whether the new contact view is displayed (it could be
                # invisible due to the current filter criterion)
                newContactView.flash("success") if newContactView
              else
                view.triggerMethod("form:data:invalid", newContact.validationError)

            ContactManager.dialogRegion.show(view)

          contactsListView.on "childview:contact:show", (childView, args) ->
            ContactManager.trigger("contact:show", args.model.get("id"))

          contactsListView.on "childview:contact:edit", (childView, args) ->
            model = args.model
            view = new ContactManager.ContactsApp.Edit.Contact(model: model)

            view.on "form:submit", (data) ->
              if model.save(data)
                childView.render()
                view.trigger("dialog:close")
                childView.flash("success")
              else
                view.triggerMethod("form:data:invalid", model.validationError)

            ContactManager.dialogRegion.show(view)

          contactsListView.on "childview:contact:delete", (childView, args) ->
            args.model.destroy()

          ContactManager.mainRegion.show(contactsListLayout)
