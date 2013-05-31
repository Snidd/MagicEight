Template.top8.helpers
	noteam: ->
		getTeamCount(Meteor.userId(), Session.get("currentTourneyId")) is 0
	haveteam: ->
		getTeamCount(Meteor.userId(), Session.get("currentTourneyId")) > 0
	tourneyName: ->
		t = Tournaments.findOne
			_id: Session.get("currentTourneyId")
		t.name
	myTeamName: ->
		t = getCurrentTeam()
		t.name
	pickRows: ->
		t = getCurrentTeam()
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
	addButtonText: (pick) ->
		if pick.name.length is 0 then return "Click to select pick"
		pick.name
	addButtonClass: (pick) ->
		if pick.name.length > 0 then return "btn-info"
		""
	currentEditing: (position) ->
		Session.get("editing-#{position}") is true

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
	'click .btn.selectPlayer' : (event, template) ->
		console.log "clicked #{this.position}"
		Session.set("editing-#{this.position}", true)
	'click .btn.addPick' : (event, template) ->
		playerName = template.find(".replaceButton.id-#{this.position}").value
		if playerName.length < 0 then return
		console.log "set #{this.position} to #{playerName}"
		this.name = playerName
		Session.set("editing-#{this.position}", false)
	'click .btn.saveteam' : (event, template) ->
		t = getCurrentTeam()
		picks = {}
		for i in [1...9] by 1
			newPosName = template.find("input.hiddenname.id-#{i}").value
			picks[i] =
				name: newPosName
				position: i
			console.log "#{i}: #{newPosName}"
		Teams.update(
			{ _id: t._id  },
			{ $set: { picks: picks } }
			)

createTeam = (teamName) ->
	newTeam = new Team(teamName, Meteor.userId(), Session.get("currentTourneyId"))
	Teams.insert newTeam

getTeamCount = (userId, tourneyId) ->
	Teams.find({ owner: userId, tourneyId: tourneyId }).count()

getCurrentTeam = ->
	getTeam(Meteor.userId(), Session.get("currentTourneyId"))	

getTeam = (userId, tourneyId) ->
	Teams.findOne
		owner: userId
		tourneyId: tourneyId