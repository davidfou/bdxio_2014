`import ContactManager from 'app'`
`import LoadingView    from 'common/loading_view'`
`import ItemView       from 'apps/contacts/show/views/item'`
`import Missing        from 'apps/contacts/show/views/missing'`

Controller =
  showContact: (id) ->
    loadingView = new LoadingView
      title: "Artificial Loading Delay",
      message: "Data loading is delayed to demonstrate using a loading view."

    ContactManager.mainRegion.show(loadingView)

    fetchingContact = ContactManager.request("contact:entity", id)
    $.when(fetchingContact).done (contact) ->
      if contact?
        contactView = new ItemView(model: contact)

        contactView.on "contact:edit", (contact) ->
          ContactManager.trigger("contact:edit", contact.get("id"))
      else
        contactView = new Missing()

      ContactManager.mainRegion.show(contactView)

`export default Controller`
