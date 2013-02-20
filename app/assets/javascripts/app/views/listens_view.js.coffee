App.Views.Listens ||= {}

class App.Views.Listens.ShowView extends Backbone.View
  initialize: ->
    alert('init')

  template: ->
    return JST["show"]

  render: ->
    $(this.el).html(this.template()(this.options.model.toJSON() ))
    return this


$ ->
  $('.playlist a').click (e) =>
    link = $(e.target)
    link.addClass('listened')

    source_id = link.data('source-id')
    user_id = link.data('user-id')

    sound_obj = pagePlayer.getSoundByObject(e.target)
    position = 0 
    position = sound_obj.position unless sound_obj == null
    listen = new App.Models.Listen({source_id: source_id, user_id: user_id, start_time: position})
    listen.save()
