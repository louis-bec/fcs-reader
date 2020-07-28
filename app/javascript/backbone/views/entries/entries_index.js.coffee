class FcsReader.Views.EntriesIndex extends Backbone.View

  template: _.template('<h1> Hello1 </h1')

  render: -> 
    $(@el).html(@template())
    this
