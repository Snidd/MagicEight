Meteor.autosubscribe ->
    Meteor.subscribe "userData"
    Meteor.subscribe "latestTournaments"
    Meteor.subscribe "myTeams"