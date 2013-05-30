Accounts.validateNewUser (user) ->
	if user.username and user.username.length > 3
		return true
	throw new Meteor.Error(401, "Username must have atleast 3 characters")

Accounts.validateNewUser (user) ->
	if user.emails.length > 0 and validEmail(user.emails[0].address)
		return true
	throw new Meteor.Error(402, "Invalid email")

Accounts.validateNewUser (user) ->
	userCount = Meteor.users.find({ username: user.username }).count()
	if userCount is 0
		return true	
	throw new Meteor.Error(401, "Username already exists :(")
