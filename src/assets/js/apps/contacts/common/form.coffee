`import template from 'templates/contact/show/edit'`

class FormView extends Marionette.ItemView
  template: template

  events:
    "click button.js-submit": "submitClicked"

  submitClicked: (e) ->
    e.preventDefault()
    data = Backbone.Syphon.serialize(@)
    @trigger("form:submit", data)

  onFormDataInvalid: (errors) ->
    $view = this.$el

    clearFormErrors = ->
      $form = $view.find("form")
      $form.find(".help-inline.error").each ->
        $(@).remove()

      $form.find(".control-group.error").each ->
        $(@).removeClass("error")

    markErrors = (value, key) ->
      $controlGroup = $view.find("#contact-" + key).parent()
      $errorEl = $("<span>", { class: "help-inline error", text: value })
      $controlGroup.append($errorEl).addClass("error")

    clearFormErrors()
    _.each(errors, markErrors)

`export default FormView`
