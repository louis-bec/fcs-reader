class FcsReader.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'

  initialize: ->
    @collection = new FcsReader.Collections.Entries()
    @collection.fetch()

  index: ->
    view = new FcsReader.Views.EntriesIndex(collection: @collection)
    $('.raffler-container').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}"