`import ContactManager from 'app'`
`import ListView       from 'apps/header/list/views/list'`

Controller =
  listHeader: ->
    links = ContactManager.request("header:entities")
    headers = new ListView({collection: links})

    headers.on "brand:clicked", ->
      ContactManager.trigger("contacts:list")

    headers.on "childview:navigate", (childView, model) ->
      trigger = model.get("navigationTrigger")
      ContactManager.trigger(trigger)

    ContactManager.headerRegion.show(headers)

  setActiveHeader: (headerUrl) ->
    links = ContactManager.request("header:entities")
    headerToSelect = links.find (header) -> header.get("url") is headerUrl
    headerToSelect.select()
    links.trigger("reset")

`export default Controller`
