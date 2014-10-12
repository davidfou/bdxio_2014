`import ContactManager from 'app'`
`import ShowMessage    from 'apps/about/show/show_view'`

Controller =
  showAbout: ->
    view = new ShowMessage()
    ContactManager.mainRegion.show(view)

`export default Controller`
