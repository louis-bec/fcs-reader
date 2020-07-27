window.FcsReader =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: -> 
    new FcsReader.Routers.Entries()
    Backbone.history.start()

$(document).ready -> 
  FcsReader.init()