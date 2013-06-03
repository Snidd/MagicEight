Template.league.helpers
	tournament: ->
		Tournaments.find({ finished:false }, { sort: { startDate: 1 }}).fetch()
	isInLeague: ->
		l = getCurrentLeague()
		t = this
		if (l and l.tournaments.some (t1) -> (t1.tourneyId is t._id)) then return true
		false
	myLeague: ->
		l = getCurrentLeague()
		l.memberCount = l.members.length
		l.memberText = if l.memberCount > 1 then "members" else "member"
		l

Template.league.events
	'click .btn.link.add' : (event, template) ->
		console.log "Add #{this._id}"
		addTourneyToLeague Session.get("currentLeagueId"), this._id
	'click .btn.link.remove' : (event, template) ->
		removeTourneyFromLeague Session.get("currentLeagueId"), this._id

addTourneyToLeague = (leagueId, tourneyId) ->
	Leagues.update { _id: leagueId }, { $push: { tournaments: { tourneyId: tourneyId } }}

removeTourneyFromLeague = (leagueId, tourneyId) ->
	Leagues.update { _id: leagueId }, { $pull: { tournaments: { tourneyId: tourneyId } }}	