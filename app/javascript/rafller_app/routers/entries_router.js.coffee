class FcsReader.Routers.Entries extends Backbone.Router
  routes:
    'raffler/index': 'index'
    'raffler/entries/:id': 'show'

  initialize: ->
    @collection = new FcsReader.Collections.Entries()

  index: ->
    @collection.fetch({reset: true})
    view = new FcsReader.Views.EntriesIndex(collection: @collection)
    $('.sub-container').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}" 