Meteor.Router.add
  '/tournaments': 'tournaments'
  '/':'tournaments'
  '/top8/:id': 
  	to: 'top8'
  	and: (id) -> Session.set('currentTourneyId', id)
  '/league/:id':
    to: 'league'
    and: (id) -> Session.set('currentLeagueId', id)
  '/signup':'signup'
  '/create':'create'
  '*': 'not_found'

Meteor.Router.filters
  'checkLoggedIn': (page) ->
      if Meteor.loggingIn() then 'loading'
      else if Meteor.user() then page
      else 'signup'

Meteor.Router.filter(
    'checkLoggedIn'
    { except: 'tournaments', 'signup'}
)

Meteor.Router.beforeRouting = ->
  Session.set('currentTourneyId', null)
  Session.set("saving", false)
  Session.set("errorMessage", "")
  for i in [1...9] by 1
    Session.set("editing-#{i}", false)