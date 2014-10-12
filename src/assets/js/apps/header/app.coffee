`import ContactManager from 'app'`
`import ListController from 'apps/header/list/controller'`

API =
  listHeader: () ->
    ListController.listHeader()


ContactManager.commands.setHandler "set:active:header", (name) ->
  ListController.setActiveHeader(name)

ContactManager.on "start", ->
  API.listHeader()
