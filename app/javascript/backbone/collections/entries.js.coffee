class FcsReader.Collections.Entries extends Backbone.Collection
	url: '/api/entries'
	model: FcsReader.Models.Entry

	drawWinner: ->
		winner = @shuffle()[0]
		winner.win() if winner
