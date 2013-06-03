Meteor.methods
	createLeague: (name, password) ->
		u = Meteor.user()
		l = new League(name, password, u._id)		
		l.members = [{ name: u.username, id: u._id }]
		Leagues.insert l, (error, id) ->
			## Automatically join this league with the users teams.
			addLeagueToAllUsersTeam u._id, id
			Meteor.Router.to "/league/#{id}"
	searchPlayer: (name) ->
		Players.find({ name: { '$regex': name, '$options': 'i' } },{ "sort": { name: 1 }, limit:10 }).fetch()
	updateStandings: (tourneyId, standingsArray) ->
		Tournaments.update({ _id: tourneyId }, { "$set" : { standings: standingsArray } })
		addPlayers(standingsArray)
		updateTeampoints(tourneyId, standingsArray)
		updateTeamstandings(tourneyId)
		return true

playerDoesntExists = (playerName, existingPlayers) ->
	exists = false
	for p in existingPlayers
		if p.name is playerName
			exists = true
			break
	exists is false

getNewPlayers = (incomingPlayers, existingPlayers) ->
	for incPlayer in incomingPlayers
		if playerDoesntExists incPlayer,existingPlayers then incPlayer

addPlayers = (playersArray) ->
	existingPlayers = Players.find({ name: { $in: playersArray }}).fetch()
	if existingPlayers.length is playersArray.length then return
	newPlayers = getNewPlayers playersArray, existingPlayers
	for playerName in newPlayers
		if playerName then Players.insert { name: playerName }

updateTeamstandings = (tourneyId) ->
	teamInPointsOrder = Teams.find({ tourneyId: tourneyId }, { points: 1 }, { sort: { points: 1 }}).fetch()
	i = 1
	for team in teamInPointsOrder
		Teams.update({ _id: team._id }, { "$set" : { standing: i }})
		i++

updateTeampoints = (tourneyId, standingsArray) ->
	allTeams = Teams.find({ tourneyId: tourneyId }).fetch()
	for team in allTeams
		points = 0
		for own key, value of team.picks
			points += getPoints standingsArray, value
		Teams.update( { _id: team._id }, { "$set" : { points: points, picks: team.picks }})	

getPoints = (standingsArray, pick) ->
	pick.realposition = -1
	pick.points = 0
	pos = standingsArray.indexOf pick.name
	if pos < 0 then return 0
	## 0 is 1
	## pick.position = guessedposition
	pick.realposition = pos+1
	pointsForPick = calculatePoints pos+1, pick.position
	pick.points = pointsForPick
	pointsForPick

calculatePoints = (correctPosition, guessedPosition) ->
	points = 50
	diff = guessedPosition - correctPosition
	if diff > 0
		points = points - diff
	else
		points = points + diff
	if points < 0 then points = 0
	if correctPosition <= 8 then points += 40
	points

## { sort: { name: 1 }, limit:10 }
## Players.find({'name': {'$regex': 'a', $options: 'i'}},{sort: {name: -1}, limit: 10}).fetch();