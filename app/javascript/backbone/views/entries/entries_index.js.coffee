class FcsReader.Views.EntriesIndex extends Backbone.View

  template: _.template("
    <h1> Raffler </h1>
    <ul>
      <% for (var i = 0; i < entries.length; i++) { %>
        <li><%= entries.at(i).get('name') %></li>
      <% } %>
    </ul>
  ")

  initialize: ->
    this.collection.on('reset', @render ,this)

  render: ->
    $(@el).html(@template(entries: @collection))
    this
