#= require_self
#= require_tree .

soundManager.setup
  url: '/assets/soundmanager2/'
  onready: ->
    console.log 'sm ready'

soundManager.setup

window.App =
  Models: {}
  Collections: {}
  Controllers: {}
  Views: {}
