Handlebars.registerHelper "tournamentdate", (startDate, endDate) ->
	startDate = moment(startDate)
	endDate = moment(endDate)
	diff = endDate.diff(startDate, 'days'); 
	startMonth = startDate.format('MMM')
	endMonth = endDate.format('MMM')
	if startMonth is endMonth
		res = startDate.format('MMM Do') + "-" + endDate.format('Do YYYY')
		return new Handlebars.SafeString(res.replaceAll(" ", "&nbsp;"))
	else
		res = startDate.format('MMM Do') + "-" + endDate.format('MMM Do YYYY')
		return new Handlebars.SafeString(res.replaceAll(" ", "&nbsp;"))

Handlebars.registerHelper "timeleft", (startDate) ->
	return moment(startDate).startOf('day').fromNow()

Handlebars.registerHelper "nobreak", (text) ->
	new Handlebars.SafeString(text.replaceAll(" ", "&nbsp;"));
