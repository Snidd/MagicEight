Template.tournaments.helpers
	tournamentRows: ->
		allTournaments = Tournaments.find({}, { sort: { startDate: 1 }}).fetch()
		tournamentsPerRow = 2
		rows = []
		i = 0
		count = 0
		for tourney in allTournaments
			if rows.length <= i
				rows.push
					tournaments: []
			rows[i].tournaments.push tourney 
			count++
			if count is tournamentsPerRow
				count = 0
				i++
		return rows