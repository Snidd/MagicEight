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

Template.loginnav.events				
	'click .login.link' : ->
		console.log "Showing login..."
		$('#loginModal').modal()
	'click #loginBtn' : (event, template) ->
		username = template.find('#usernameField').value
		password = template.find('#passwordField').value
		Meteor.loginWithPassword username, password, (error) ->
			if not error
				closeModal(template)
			else
				console.log error.reason

	'click #cancelBtn' : (event, template) ->
		closeModal(template)

closeModal = (template) ->
	template.find('#usernameField').value = ''
	template.find('#passwordField').value = ''
	$('#loginModal').modal('hide')
