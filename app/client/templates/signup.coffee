Template.signup.events
	'submit #signupform' : (event, template) ->
		username = template.find("input.username").value
		email = template.find("input.email").value
		password = template.find("input.password").value
		if validEmail(email) and password.length > 0 and username.length > 3
			toggleForm()
			console.log "Trying to sign up!"
			Accounts.createUser { username: username, email: email, password: password }, (error) ->
				switch error?.error
	        when 401
	        	console.log "Username problem: #{error.message}"
	        	setControlGroupMessage "username", "error", error.reason
	        	toggleForm(true)
	        when 402
	          console.log "Email problem: #{error.message}"
	          setControlGroupMessage "email", "error", error.reason
	          toggleForm(true)
	        when 403
	        	setControlGroupMessage "password", "error", error.reason
	        	console.log "Password problem: #{error.message}"
	        	toggleForm(true)
	      if !error then Meteor.Router.to('/tournaments');
			return false
		else
			console.log "Invalid form!"
		return false
	'blur .username' : ->
		console.log "checking username..."
	'blur .email' : (event, template) ->
		email = template.find("input.email").value
		if not validEmail(email)
			setControlGroupMessage("email", "error", "Invalid email")
		else
			setControlGroupMessage("email", "ok")

toggleForm = (enable) ->
	if enable
		$("#submitbtn").removeClass("disabled")
	else
		$("#submitbtn").addClass("disabled")

setControlGroupMessage = (type, status, message) ->
	$(".control-group.#{type}").removeClass("ok")
	$(".control-group.#{type}").removeClass("info")
	$(".control-group.#{type}").removeClass("error")
	$(".control-group.#{type}").addClass(status)
	$(".help-inline.#{type}").text(message)