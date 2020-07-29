class FcsReader.Views.Entry extends Backbone.View

	template: _.template("
    <%= entry.get('name') %>
		<% if (entry.get('winner')) {%>
			<span class='winner'> WINNER </span>
		<% } %>
  ")

	tagName: 'li'

	initialize: ->
		@model.on('change', @render, this)
		@model.on('highlight', @highlightWinner, this)

	render: ->
		$(@el).html(@template(entry: @model))
		this
	
	highlightWinner: ->
		$('.winner').removeClass('highlight')
		@$('.winner').addClass('highlight')
