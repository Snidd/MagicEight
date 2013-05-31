Meteor.Router.add
  '/tournaments': 'tournaments'
  '/':'tournaments'
  '/top8/:id': 
  	to: 'top8'
  	and: (id) -> Session.set('currentTourneyId', id)
  '/signup':'signup'
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