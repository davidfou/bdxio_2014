`import FormView from 'apps/contacts/common/form'`

class EditContact extends FormView
  initialize: ->
    @title = "Edit #{@model.get("firstName")} #{@model.get("lastName")}"

  onRender: ->
    if @options.generateTitle
      $title = $('<h1>', text: this.title)
      @$el.prepend($title)

    @$(".js-submit").text("Update contact")

`export default EditContact`
