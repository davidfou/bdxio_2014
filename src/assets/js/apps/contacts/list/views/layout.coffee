`import template from 'templates/contact/list/layout'`

class Layout extends Marionette.LayoutView
  template: template

  regions:
    panelRegion: "#panel-region"
    contactsRegion: "#contacts-region"

`export default Layout`
