Template.admin.helpers
	tournament: ->
		Tournaments.find({}).fetch()

Template.admintournament.helpers
	thisTournament: ->
		getCurrentTournament()
	started: ->
		this.started is true
	finished: ->
		this.finished
	isUpdating: ->
		Session.get("updatingStandings") is true

Template.admintournament.events
	'click .btn.start' : (event, template) ->
		Tournaments.update({ _id: this._id}, { "$set" : { started: true } })
	'click .btn.stop' : (event, template) ->
		Tournaments.update({ _id: this._id}, { "$set" : { started: false } })
	'click .btn.updatestandings' : (event, template) ->
		Session.set("updatingStandings", true)
		currentStandings = template.find("textarea.playerstandings").value
		standingsRegex = /^[\d]+\s*([^[]+)/igm
		standings = []
		while (matches = standingsRegex.exec currentStandings)
			standings.push trim11(matches[1])
		console.log "Setting standings to #{standings}"		
		Meteor.call "updateStandings", this._id, standings, (error, result) ->
			Session.set("updatingStandings", false)
			if error
				console.log "Error: #{error}"
	'click .btn.finish' : (event, template) ->
		Tournaments.update({ _id : this._id }, { "$set" : { finished : true}} )
	'click .btn.remove' : (event, template) ->
		Tournaments.remove { _id: this._id }, (error, results) ->
			if not error
				Meteor.Router.to 'admin'

Template.admincreate.rendered = ->
	$.datepicker.setDefaults
		showOn: "both"
		buttonImageOnly: false
		buttonText: "Calendar"
 	$("input.startdate").datepicker()
 	$("input.enddate").datepicker()

Template.admincreate.helpers
	selectedCountryClass: ->
		return "flag-#{Session.get('chosenCountry')}" 

Template.admincreate.events
	'change .countryCode' : (event, template) ->
		Session.set("chosenCountry", event.currentTarget.value)
	'submit #createtourneyform' : (event, template) ->
		tn = template.find("input.tournamentname").value
		startDate = new Date(template.find(".startdate").value)
		endDate = new Date(template.find(".enddate").value)
		countryCode = template.find('.countryCode').value
		format = template.find(".format").value
		type = template.find("select.type").value
		console.log "Creating #{tn} from #{countryCode} starting #{startDate} through #{endDate} with format #{format}"
		t = new Tournament tn, countryCode, startDate, endDate, format, type
		Tournaments.insert t, (error, results) ->
			if not error 
				Meteor.Router.to('admin')
			else
				console.log "This didnt work... #{error}"
		return false