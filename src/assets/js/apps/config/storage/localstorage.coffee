ContactManager.module "Entities",
  (Entities, ContactManager, Backbone, Marionette, $, _) ->
    findStorageKey = (entity) ->
      # use a model's urlRoot value
      return _.result(entity, "urlRoot") if entity.urlRoot

      # use a collection's url value
      return _.result(entity, "url") if entity.url

      # fallback to obtaining a model's storage key from
      # the collection it belongs to
      if entity.collection and entity.collection.url
        return _.result(entity.collection, "url")

      throw new Error("Unable to determine storage key")

    StorageMixin = (entityPrototype) ->
      storageKey = findStorageKey(entityPrototype)
      return localStorage: new Backbone.LocalStorage(storageKey)

    Entities.configureStorage = (entity) ->
      _.extend(entity.prototype, new StorageMixin(entity.prototype))
