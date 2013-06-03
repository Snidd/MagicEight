Meteor.publish "userData", ->
	Meteor.users.find {_id: this.userId}, {fields: { 'admin': 1 }}

Meteor.publish "latestTournaments", ->
	Tournaments.find {}

Meteor.publish "myTeams", ->
	Teams.find { owner: this.userId }

Meteor.publish "team", (id) ->
	te = Teams.findOne { _id: id }
	to = Tournaments.findOne { _id : te.tourneyId }
	if to.started or to.finished or (te.owner is this.userId)
		Teams.find { _id: id }
	else
		this.error(new Meteor.Error(301, "Access denied", "You cannot view this team yet. It will be revealed when the tournament starts."))

Meteor.publish "teams", (tourneyId) ->
	Teams.find( {tourneyId: tourneyId}, {fields: { name: 1, standing: 1, points: 1, tourneyId: 1, ownerName: 1 }}, { sort: { standing: 1 }, limit: 100 })