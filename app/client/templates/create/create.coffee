Template.create.events
	'submit #createLeagueForm' : (event, template) ->
		console.log "Creating!"
		pw = template.find("input.password")
		name = template.find("input.leaguename")
		if pw and name
			Meteor.call "createLeague", name.value, pw.value, ->
				console.log "test"
		return false