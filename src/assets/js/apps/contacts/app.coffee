`import ContactManager from 'app'`
`import Router         from 'apps/contacts/router'`
`import ListController from 'apps/contacts/list/controller'`
`import ShowController from 'apps/contacts/show/controller'`
`import EditController from 'apps/contacts/edit/controller'`

API =
  listContacts: (criterion) ->
    ListController.listContacts(criterion)
    ContactManager.execute("set:active:header", "contacts")

  showContact: (id) ->
    ShowController.showContact(id)
    ContactManager.execute("set:active:header", "contacts")

  editContact: (id) ->
    EditController.editContact(id)
    ContactManager.execute("set:active:header", "contacts")

ContactManager.on "contacts:list", ->
  ContactManager.navigate("contacts")
  API.listContacts()

ContactManager.on "contacts:filter", (criterion) ->
  if criterion
    ContactManager.navigate("contacts/filter/criterion:" + criterion)
  else
    ContactManager.navigate("contacts")

ContactManager.on "contact:show", (id) ->
  ContactManager.navigate("contacts/" + id)
  API.showContact(id)

ContactManager.on "contact:edit", (id) ->
  ContactManager.navigate("contacts/" + id + "/edit")
  API.editContact(id)

ContactManager.addInitializer ->
  new Router(controller: API)
