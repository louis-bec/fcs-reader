class FcsReader.Views.EntriesIndex extends Backbone.View

  template: _.template("
    <h1> Raffler </h1>
    <ul>
      <% for (entry of entries) { %>
        <li><%= entry.get('name') %></li>
      <% } %>
    </ul>
  ")

  initialize: ->
    this.collection.on('reset', @render ,this)

  render: ->
    $(@el).html(@template(entries: @collection))
    this
