Template.tournaments.helpers
	tournamentRows: ->
		allTournaments = Tournaments.find({}, { sort: { startDate: 1 }}).fetch()
		tournamentsPerRow = 2
		rows = []
		i = 0
		count = 0
		for tourney in allTournaments
			if rows.length <= i
				rows.push
					tournaments: []
			rows[i].tournaments.push tourney 
			count++
			if count is tournamentsPerRow
				count = 0
				i++
		return rows
	loggedIn: ->
		isLoggedIn()
	isStarted: ->
		this.started is true
	showPick: (t) ->
		if not isLoggedIn() then return false
		if t.finished then return false
		if t.started then return false
		if getTeamCount(Meteor.userId(), t._id) > 0 then return false
		true
	hasTeam: (t) ->		
		getTeamCount(Meteor.userId(), t._id) > 0
	myTeam: (t) ->
		t = getTeam(Meteor.userId(), t._id)
		t.leagues = []
		t
	leagueDescription: ->
		 if this.leagues?.length > 0
		 	return "in the following leagues"
		 else
		 	return "in no leagues."
	tournamentsReady: ->
		console.log (Session.get("tournamentsReady") is true)
		Session.get("tournamentsReady") is true

Template.tournaments.rendered = ->
	console.log "Subscribing..."
	Meteor.subscribe "latestTournaments", { onError: unableToSubscribe, onReady: subscriptionReady }

unableToSubscribe = (error) ->
	console.log "Unable to get data. #{error.reason}"

subscriptionReady = ->
	console.log "Subscription ready."
	Session.set("tournamentsReady", true)

Template.tournaments.events
	'click button.pick' : (event, template) ->
		Meteor.Router.to(Meteor.Router.createteamPath(this._id))