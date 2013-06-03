Template.displayPick.helpers
	pickfound: ->
		if this.realposition and this.realposition > 0 and this.points and this.points > 0 then return true
		false

Template.top8.helpers
	getStanding: ->
		if this.standing then this.standing else "Unknown"
	loggedIn: ->
		isLoggedIn()
	selectedTeam: ->
		Teams.findOne { _id: Session.get("currentTeamId") }
	noteam: ->
		getTeamCount(Meteor.userId(), Session.get("currentTourneyId")) is 0
	haveteam: ->
		getTeamCount(Meteor.userId(), Session.get("currentTourneyId")) > 0
	tourneyName: ->
		t = Tournaments.findOne
			_id: this.tourneyId
		t.name
	tourneyStarted: ->
		t = Tournaments.findOne
			_id: this.tourneyId
		if t
			return t.started is true
		true
	allowedToMakeChanges: ->
		if this.owner isnt Meteor.userId() then return false
		t = Tournaments.findOne
			_id: this.tourneyId
		if t
			return (t.started is false) and (t.finished is false) 
		false
	pickRows: ->
		t = this
		picksPerRow = 2
		rows = []
		i = 0
		count = 0
		for k,v of t.picks
			if rows.length <= i
				rows.push
					picks: []
			rows[i].picks.push v 
			count++
			if count is picksPerRow
				count = 0
				i++
		return rows
	errorMessage: ->
		Session.get("errorMessage")
	wasError: ->
		msg = Session.get("errorMessage")
		msg and msg.length > 0
	saving: ->
		Session.get("saving") is true

Template.top8.rendered = ->
	Deps.autorun ->
		Meteor.subscribe "team", Session.get("currentTeamId"), { onError: unableToSubscribe }

unableToSubscribe = (error) ->
	console.log error.details
	Session.set("errorMessage", error.details)

Template.top8pick.rendered = ->
	i = this.find("input.playerName.id-#{this.data.position}")
	if i 
		i.focus()
		debouncedFindPlayerName = _.debounce(findPlayerName, 500)
		$("input.playerName.id-#{this.data.position}").typeahead({ source: debouncedFindPlayerName, minLenght: 2})

findPlayerName = (query, promise) ->
	Meteor.call "searchPlayer", query, (error, result) ->
		if not error		
			res = []
			for player in result
				res.push player.name
			promise(res)
	false

##var lazyLayout = _.debounce(calculateLayout, 300);


Template.top8pick.helpers
	addButtonText: (pick) ->
		if pick.name.length is 0 then return "Click to select pick"
		pick.name
	addButtonClass: (pick) ->
		if pick.name.length > 0 then return "btn-info"
		""
	currentEditing: (position) ->
		Session.get("editing-#{position}") is true

Template.top8pick.events
	'click .btn.playerName' : (event, template) ->
		Session.set("editing-#{this.position}", true)
	'click .btn.addPick' : (event, template) ->
		savePick template, this
	'keypress input.playerName' : (event, template) ->
		if (event.keyCode is 13)
			savePick template, this

savePick = (template, pick) ->
	playerName = template.find(".replaceButton.id-#{pick.position}").value
	if playerName.length < 0 then return
	console.log "set #{pick.position} to #{playerName}"
	pick.name = playerName
	Session.set("editing-#{pick.position}", false)

Template.createteam.helpers
	errorMessage: ->
		Session.get("errorMessage")
	wasError: ->
		msg = Session.get("errorMessage")
		msg and msg.length > 0

Template.createteam.events
	'submit #createteamform' : (event, template) ->
		teamNameInput = template.find("input.teamname")
		if not teamNameInput then return false
		teamName = teamNameInput.value
		if teamName and teamName.length > 0
			console.log "Creating team..."
			newTeam = new Team(teamName, Meteor.userId(), Session.get("currentTourneyId"), Meteor.user().username)
			Teams.insert newTeam, (error, results) ->
				if error then Session.set("errorMessage", error.reason) else Meteor.Router.to(Meteor.Router.top8Path(results))
			return false
		else
			return false

Template.top8.events
	'click #saveTeamBtn' : (event, template) ->
		teamNameInput = template.find("input.teamname")
		if not teamNameInput then return false
		teamName = teamNameInput.value
		if teamName and teamName.length > 0
			console.log "Creating team..."
			createTeam(teamName)
			return false
		else
			return false
	'click .btn.saveteam' : (event, template) ->
		Session.set("saving", true)
		t = this
		picks = {}
		for i in [1...9] by 1
			newPosName = template.find("input.hiddenname.id-#{i}").value
			newInput = template.find("input.playerName.id-#{i}")
			if newInput
				newPosName = newInput.value
				Session.set("editing-#{i}", false)
			picks[i] =
				name: newPosName
				position: i
			console.log "#{i}: #{newPosName}"
		Teams.update { _id: t._id  },{ $set: { picks: picks }}, (error) ->
			Session.set("saving", false)
			if error
				Session.set("errorMessage", error.reason)

createTeam = (teamName) ->
	

