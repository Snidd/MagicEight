@validEmail = (email) ->
	re = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i
	return re.test(email);

@isLoggedIn = ->
	if Meteor.user() is null then return false
	return true

@delay = (ms, func) -> setTimeout func, ms

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