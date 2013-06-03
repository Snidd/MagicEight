Teams.allow
  insert: (userId, doc) ->
    ## the user must be logged in, and the document must be owned by the user
    alreadyCount = Teams.find({ name: doc.name, tourneyId: doc.tourneyId }).count()
    if alreadyCount > 0 then throw new Meteor.Error 406, "Teamname already exists, pick another name."
    myTeamCount = Teams.find({ tourneyId: doc.tourneyId, owner: doc.owner }).count()
    if myTeamCount > 0 then throw new Meteor.Error 406, "You already have a team for this tournament!"
    t = Tournaments.findOne _id: doc.tourneyId
    if t.started then throw new Meteor.Error 405, "This tournament has already started!"
    if t.finished then throw new Meteor.Error 405, "This tournament has already finished!"
    return userId and doc.owner is userId
  update: (userId, doc, fields, modifier) ->
    ## can only change your own documents, cannot modify teams when tournament has started or finished.
    t = Tournaments.findOne _id: doc.tourneyId
    (doc.owner is userId) and (t.started is not true) and (t.finished is not true)
  remove: (userId, doc) ->
    ## can only remove your own documents
    t = Tournaments.findOne _id: doc.tourneyId
    (doc.owner is userId) and (t.started is not true) and (t.finished is not true)
  fetch: ['owner', 'tourneyId', 'name']

Tournaments.allow
  insert: (userId, doc) ->
    Meteor.user() and Meteor.user().admin
  update: (userId, doc, fields, modifier) ->
    Meteor.user() and Meteor.user().admin
  remove: (userId, doc) ->
    Meteor.user() and Meteor.user().admin
  fetch: ['name']