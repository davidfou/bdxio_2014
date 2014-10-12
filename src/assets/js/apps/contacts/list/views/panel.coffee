class Panel extends Marionette.ItemView
  template: JST["contact/list/panel"]

  triggers:
    "click button.js-new": "contact:new"

  events:
    "submit #filter-form": "filterContacts"

  ui:
    criterion: "input.js-filter-criterion"

  filterContacts: (e) ->
    e.preventDefault()
    criterion = this.$(".js-filter-criterion").val()
    @trigger("contacts:filter", criterion)

  onSetFilterCriterion: (criterion) ->
    @ui.criterion.val(criterion)

`export default Panel`
