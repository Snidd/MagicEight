Template.usernav.events
	'click .logout.link' : ->
		console.log "Logging out!"
		Meteor.logout (error) ->
			if not error 
				console.log "Done!"
				return false
			else
				console.log error.message
				return false

Template.usernav.helpers
	isAdmin: -> if Meteor.user() and Meteor.user().admin then true else false

addAlert = (message) ->
	alertId = Random.id()
	alertDiv = "<div id='#{alertId}' class='alert alert-error'><button type='button' class='close' data-dismiss='alert'>&times;</button>#{message}</div>"
	$("#cancelBtn").after(alertDiv)
	delay 7000, ->
		$("#" + alertId).remove()		

Template.leaguenav.helpers
	myLeagues: ->
		Leagues.find( { ownerId: Meteor.userId() }, { sort: { name: 1 }}).fetch()

Template.loginnav.events				
	'click .login.link' : ->
		console.log "Showing login..."
		$('#loginModal').on 'shown', ->
			$('#usernameField').focus()
		$('#loginModal').modal()
	'click #loginBtn' : (event, template) ->
		username = template.find('#usernameField').value
		password = template.find('#passwordField').value
		Meteor.loginWithPassword username, password, (error) ->
			if not error
				closeModal(template)
				Meteor.Router.to('tournaments')
			else
				addAlert error.reason
				console.log error.reason
		return false

	'click #cancelBtn' : (event, template) ->
		closeModal(template)

closeModal = (template) ->
	uname = document.getElementById("usernameField");
	if uname then uname.value = ''

	pw = document.getElementById("passwordField");
	if pw then pw.value = ''
	
	$('#loginModal').modal('hide')
