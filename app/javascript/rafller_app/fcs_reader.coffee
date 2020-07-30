window.FcsReader =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: -> 
    new FcsReader.Routers.Entries()
    Backbone.history.start(pushState: true)

$(document).ready -> 
  FcsReader.init()
  # token = $('meta[name="csrf-token"]').attr('content');
  # Backbone.Model.prototype.toJSON = () -> 
  #   _(_.clone(this.attributes)).extend({
  #       authenticity_token: token
  #   })
  Backbone._sync = Backbone.sync;
  Backbone.sync = (method, model, options) -> 
    if (!options.noCSRF)
      beforeSend = options.beforeSend;

      # Set X-CSRF-Token HTTP header
      options.beforeSend = (xhr) ->
        token = $('meta[name="csrf-token"]').attr('content')
        if (token)
          xhr.setRequestHeader('X-CSRF-Token', token)
        if (beforeSend)  
          return beforeSend.apply(this, arguments)
    return Backbone._sync(method, model, options)