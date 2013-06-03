Meteor.Router.add
  '/tournaments': 'tournaments'
  '/':'tournaments'
  '/top8/:id': 
  	to: 'top8'
  	and: (id) -> Session.set('currentTeamId', id)
  '/createteam/:id':
    to: 'createteam'
    and: (id) -> Session.set("currentTourneyId", id)
  '/highscore/:id': 
    to: 'highscore'
    and: (id) -> Session.set('currentTourneyId', id)
  '/league/:id':
    to: 'league'
    and: (id) -> Session.set('currentLeagueId', id)
  '/admin':'admin'
  '/admin/tourney/:id':
    to: 'admintournament'
    and: (id) -> Session.set("currentTourneyId", id)
  '/admin/create':'admincreate'
  '/signup':'signup'
  '/create':'create'
  '*': '404'

Meteor.Router.filters
  'checkLoggedIn': (page) ->
      ##if Meteor.loggingIn() then 'loading'
      if Meteor.user() then page
      else 'signup'
  'checkAdmin' : (page) ->
      if Meteor.user() and Meteor.user().admin then page
      else '404'

Meteor.Router.filter(
    'checkLoggedIn', { except: ['tournaments', 'signup', '404', 'top8', 'highscore'] }
)

Meteor.Router.filter(
  'checkAdmin', { only: [ 'admin' ] }
)

Meteor.Router.beforeRouting = ->
  Session.set('currentTourneyId', null)
  Session.set("saving", false)
  Session.set("errorMessage", "")
  Session.set("teamsReady", false)
  for i in [1...9] by 1
    Session.set("editing-#{i}", false)