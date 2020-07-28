class FcsReader.Views.EntriesIndex extends Backbone.View

  template: _.template("
    <h1> Raffler#index </h1>
    <%= entries.length %> 
  ")

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template({entries: @collection}))
    this
