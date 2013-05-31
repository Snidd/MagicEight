Template.create.events
	'submit #createLeagueForm' : (event, template) ->
		console.log "Creating!"
		pw = template.find("input.password")
		name = template.find("input.leaguename")
		if pw and name
			l = new League(name.value, pw.value, Meteor.userId())
			Leagues.insert l, (error, id) ->
				Meteor.Router.to "/league/#{id}"
		return false