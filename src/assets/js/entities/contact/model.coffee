`import configureStorage from 'apps/config/storage/localstorage'`

class Model extends Backbone.Model
  urlRoot: "contacts"

  defaults:
    firstName: ""
    lastName: ""
    phoneNumber: ""

  validate: (attrs, options) ->
    errors = {}
    errors.firstName = "can't be blank" unless attrs.firstName
    unless attrs.lastName
      errors.lastName = "can't be blank" unless attrs.lastName
    else if attrs.lastName.length < 2
      errors.lastName = "is too short";

    return errors unless _.isEmpty(errors)

configureStorage(Model)

`export default Model`
