class FcsReader.Views.EntriesIndex extends Backbone.View

  template: _.template("
    <h1> Raffler </h1>
    <form id='new_entry'>
      <input type='text' name='name' id='new_entry_name'>
      <input type='submit' value='Add'>
    </form>
    <ul>
      <% for (entry of entries) { %>
        <li><%= entry.get('name') %></li>
      <% } %>
    </ul>
  ")

  events: 
    'submit #new_entry': 'createEntry'

  initialize: ->
    this.collection.on('reset', @render ,this)

  render: ->
    $(@el).html(@template(entries: @collection))
    this

  createEntry: (event) -> 
    event.preventDefault()
    @collection.create name: $('#new_entry_name').val()