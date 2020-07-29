class FcsReader.Views.EntriesIndex extends Backbone.View

	template: _.template("
    <h1> Raffler </h1>
    <form id='new_entry'>
      <input type='text' name='name' id='new_entry_name'>
      <input type='submit' value='Add'>
    </form>
    <ul id='entries'></ul>

    <button id='draw'> Draw Winner </button>
  ")

	events: 
		'submit #new_entry': 'createEntry'
		'click #draw': 'drawWinner'

	initialize: ->
		this.collection.on('reset', @render ,this)
		this.collection.on('add', @appendEntry ,this)

	render: ->
		$(@el).html(@template())
		@collection.each(@appendEntry)
		this

	appendEntry: (entry) ->
		view = new FcsReader.Views.Entry(model: entry)
		$('#entries').append(view.render().el)

	createEntry: (event) -> 
		event.preventDefault()
		attributes = name: $('#new_entry_name').val()
		@collection.create attributes, { wait: true, success: @successHanlde, error: @handleError }

	successHanlde: ->
		$('#new_entry')[0].reset()

	handleError: (entry, response) ->
		if response?
			console.log(response.responseJSON)

	drawWinner: (event) ->
		event.preventDefault()
		console.log('draw')
		@collection.drawWinner()

