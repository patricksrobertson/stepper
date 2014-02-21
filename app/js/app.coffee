Ember.OAuth2.config = {
  snowflake: {
    providerId: 'snowflake'
    clientId: "3afc0207d6d4efee624ce6049bead840a5ac0ec63e55445988ad09b61bb06869"
    authBaseUri: "http://lolololol.com"
    redirectUri: "http://tenk-steps.herokuapp.com/auth.html"
    scope: "user"
  }
}

@App = Ember.Application.create()
@App.OAuth = Ember.OAuth2.create(providerId: "snowflake")
@App.OAuth.reopen({ onFailure: -> window.location = '/error.html' })
@App.OAuth.reopen({ onSuccess: ->
  accessTokenStr = window.localStorage.getItem('token-snowflake')
  accessTokenJson = JSON.parse(accessTokenStr)
  window.App.AccessToken = accessTokenJson['access_token']
})

@App.MeAdapter = DS.RESTAdapter.extend
  host: 'https://snowflake-staging.icisapp.com'
  namespace: 'api/v1'

  pathForType: (type) ->
    type

@App.ApplicationSerializer = DS.RESTSerializer.extend
  primaryKey: 'uid'
  normalizePayload: (type, payload) ->
    { "mes": [payload] }

@App.Router.reopen({
  location: 'history'
})

@App.Router.map ->
  @route "auth", path: '/auth.html'
  @route "me"

# put your routes here
@App.IndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    App.OAuth.authorize()

@App.MeRoute = Ember.Route.extend
  model: ->
    @.store.findQuery('me', access_token: App.AccessToken, format: 'json')

@App.Me = DS.Model.extend
  first_name: DS.attr(),
  last_name: DS.attr(),
  birst_username: DS.attr(),
  email: DS.attr(),
  npi_number: DS.attr(),
  phone: DS.attr()
  practiceUsers: DS.attr()

  fullName: (->
    if @get('first_name') and @get('last_name')
      "#{@get('first_name')} #{@get('last_name')}"
  ).property 'first_name', 'last_name'