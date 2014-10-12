class Marionette.Region.Dialog extends Marionette.Region
  onShow: (view) ->
    @listenTo(view, "dialog:close", @closeDialog)

    @$el.dialog
      modal: true,
      title: view.title,
      width: "auto",
      close: (e, ui) =>
        @closeDialog()

  closeDialog: ->
    @stopListening()
    @empty()
    @$el.dialog("destroy")
