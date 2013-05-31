class @Team
	constructor: (@name, @owner, @tourneyId) ->
		@picks =
			1: { name: "", position: 1 }
			2: { name: "", position: 2 }
			3: { name: "", position: 3 }
			4: { name: "", position: 4 }
			5: { name: "", position: 5 }
			6: { name: "", position: 6 }
			7: { name: "", position: 7 }
			8: { name: "", position: 8 }
		@leagues = []

class @League
	constructor: (@name, @password, @ownerId) ->
		@tournaments = []
		@members = []