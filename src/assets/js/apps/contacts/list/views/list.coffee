`import templateList from 'templates/contact/list'`
`import templateEmpty from 'templates/contact/list/none'`
`import ContactView from 'apps/contacts/list/views/item'`

class NoContactsView extends Marionette.ItemView
  template: templateEmpty
  tagName: "tr"
  className: "alert"

class ContactsView extends Marionette.CompositeView
  tagName: "table"
  className: "table table-hover"
  template: templateList
  emptyView: NoContactsView
  childView: ContactView
  childViewContainer: "tbody"

  initialize: ->
    @listenTo @collection, "reset", ->
      @attachHtml = (collectionView, childView, index) ->
        collectionView.$el.append(childView.el)

  onRenderCollection: ->
    @attachHtml = (collectionView, childView, index) ->
      collectionView.$el.prepend(childView.el)

`export default ContactsView`
