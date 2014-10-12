`import FormView from 'apps/contacts/common/form'`

class View extends FormView
  title: "New Contact"

  onRender: ->
    @$(".js-submit").text("Create contact")

`export default View`
