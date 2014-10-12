`import ContactManager from 'app'`
`import LoadingView    from 'common/loading_view'`
`import EditView       from 'apps/contacts/edit/edit_view'`
`import MissingView    from 'apps/contacts/show/views/missing'`

Controller =
  editContact: (id) ->
    loadingView = new LoadingView
      title: "Artificial Loading Delay"
      message: "Data loading is delayed to demonstrate using a loading view."

    ContactManager.mainRegion.show(loadingView)

    fetchingContact = ContactManager.request("contact:entity", id)
    $.when(fetchingContact).done (contact) ->
      if contact?
        view = new EditView
          model: contact
          generateTitle: true

        view.on "form:submit", (data) ->
          if contact.save(data)
            ContactManager.trigger("contact:show", contact.get("id"))
          else
            view.triggerMethod("form:data:invalid", contact.validationError)
      else
        view = new MissingView()

      ContactManager.mainRegion.show(view)

`export default Controller`
