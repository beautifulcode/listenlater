App.Views.Listens ||= {}

class App.Views.Listens.ShowView extends Backbone.View
  template: ->
    return JST["show"]

  render: ->
    $(this.el).html(this.template()(this.options.model.toJSON() ))
    return this

