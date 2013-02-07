App.Views.Subscriptions ||= {}

class App.Views.Subscriptions.ShowView extends Backbone.View
  template: ->
    return JST["show"]
   
  render: ->
    $(this.el).html(this.template()(this.options.model.toJSON() ))
    return this

$ ->
  $('.subscribable').click (e) ->
    e.preventDefault()
    title = $(this).data('title')
    url = $(this).data('url')
    user_id = $(this).data('user')
    subscription = new App.Models.Subscription({user_id: user_id, title: title, url: url})
    subscription.save()
    $(this).removeClass('subscribable').removeClass('btn-primary').text('Subscribed!')
    #$('.subscription-list li:first-child').effect('highlight', {}, 3000)
    #$('.subscription-list li:first-child').effect('highlight', {}, 3000)

