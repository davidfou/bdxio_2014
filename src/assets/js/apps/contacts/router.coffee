class Router extends Marionette.AppRouter
  appRoutes:
    "contacts(/filter/criterion::criterion)": "listContacts"
    "contacts/:id": "showContact"
    "contacts/:id/edit": "editContact"

`export default Router`
