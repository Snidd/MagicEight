@validEmail = (email) ->
	re = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i
	return re.test(email);

@isLoggedIn = ->
	if Meteor.user() is null then return false
	return true

@delay = (ms, func) -> setTimeout func, ms

@getTournament = (tourneyId) ->
	Tournaments.findOne({ _id: tourneyId })

@getCurrentTournament = ->
	getTournament Session.get("currentTourneyId")

@getCurrentTeam = ->
	getTeam(Meteor.userId(), Session.get("currentTourneyId"))	

@getTeam = (userId, tourneyId) ->
	Teams.findOne
		owner: userId
		tourneyId: tourneyId

@getTeamCount = (userId, tourneyId) ->
	Teams.find({ owner: userId, tourneyId: tourneyId }).count()

@getCurrentTeamCount = ->
	getTeamCount(Meteor.userId(), Session.get("currentTourneyId"))

@getCurrentLeague = ->
	getLeague(Session.get("currentLeagueId"))

@getLeague = (id) ->
	Leagues.findOne
		_id: id

@addLeagueToAllUsersTeam = (userId, leagueId) ->
	l = Leagues.findOne({ _id: leagueId })
	Teams.update { owner: userId }, { $push: { leagues: { leagueId: leagueId, name: l.name } }}