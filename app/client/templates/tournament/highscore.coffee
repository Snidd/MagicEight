Template.highscore.helpers
	loggedIn: ->
		isLoggedIn()
	drawHighscore: ->
		Session.get("teamsReady") is true
	team: ->
		teams = Teams.find({ tourneyId: Session.get("currentTourneyId")}, { sort: { standing: 1 } }).fetch()
		teams

Template.highscore.rendered = ->
	Deps.autorun ->
		Meteor.subscribe "teams", Session.get("currentTourneyId"), { onError: unableToSubscribe, onReady: subscriptionReady }

subscriptionReady = ->
	Session.set("teamsReady", true)

unableToSubscribe = (error) ->
	console.log error.reason