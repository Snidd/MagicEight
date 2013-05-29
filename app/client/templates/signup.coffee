Template.signup.events
	'submit #signupform' : (event, template) ->
		username = template.find("input.username").value
		email = template.find("input.email").value
		password = template.find("input.password").value
		if validEmail(email) and password.length > 0 and username.length > 3
			$("#submitbtn").addClass("disabled")
			console.log "Trying to sign up!"
		else
			console.log "Invalid form!"

		false
	'blur .username' : ->
		console.log "checking username..."
		$(".control-group.username").toggleClass("ok")
		$(".control-group.username").toggleClass("info")
	'blur .email' : (event, template) ->
		email = template.find("input.email").value
		if not validEmail(email)
			$(".control-group.email").removeClass("ok")
			$(".control-group.email").addClass("error")
		else
			$(".control-group.email").addClass("ok")
			$(".control-group.email").removeClass("error")
		console.log email

validEmail = (email) ->
	re = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
	return re.test(email);