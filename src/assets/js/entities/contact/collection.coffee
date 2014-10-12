`import ContactManager   from 'app'`
`import configureStorage from 'apps/config/storage/localstorage'`
`import Model            from 'entities/contact/model'`

class Collection extends Backbone.Collection
  url: "contacts"
  model: Model
  comparator: "firstName"

configureStorage(Collection)

initializeContacts = ->
  contacts = new Collection [
    { id: 1, firstName: "Alice", lastName: "Arten", phoneNumber: "555-0184" }
    { id: 2, firstName: "Bob", lastName: "Brigham", phoneNumber: "555-0163" }
    { id: 3, firstName: "Charlie", lastName: "Campbell", phoneNumber: "555-0129" }
  ]

  contacts.forEach (contact) ->
    contact.save()

  return contacts.models

API =
  getContactEntities: ->
    contacts = new Collection()
    defer = $.Deferred()

    contacts.fetch
      success: (data) ->
        defer.resolve(data)

    promise = defer.promise()
    $.when(promise).done (contacts) ->
      # if we don't have any contacts yet, create some for convenience
      contacts.reset(initializeContacts()) if contacts.length is 0

    return promise

  getContactEntity: (contactId) ->
    contact = new Model({id: contactId})
    defer = $.Deferred()

    callback = ->
      contact.fetch
        success: (data) ->
          defer.resolve(data)
        error: (data) ->
          defer.resolve(undefined)
    setTimeout(callback, 2000)

    return defer.promise()

ContactManager.reqres.setHandler "contact:entities", ->
  return API.getContactEntities()

ContactManager.reqres.setHandler "contact:entity", (id) ->
  return API.getContactEntity(id)
