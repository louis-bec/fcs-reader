class FcsReader.Views.EntriesIndex extends Backbone.View

  template: _.template("
    <h1> Raffler </h1>
    <ul>
      <% for (var i = 0; i < entries.length; i++) { %>
        <li><%= i %></li>
      <% } %>
    </ul>
  ")

  initialize: ->
    this.collection.on('all', @render, this)

  render: ->
    $(@el).html(@template(entries: @collection))
    this
