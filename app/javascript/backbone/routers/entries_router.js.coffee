class FcsReader.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'
  
  index: ->
    view = new FcsReader.Views.EntriesIndex()
    $('raffler-container').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}"