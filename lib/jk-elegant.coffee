JokeElegantView = require './jk-elegant-view'
{CompositeDisposable} = require 'atom'

module.exports = JokeElegant =
  jokeElegantView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @jokeElegantView = new JokeElegantView(state.jokeElegantViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @jokeElegantView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'jk-elegant:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @jokeElegantView.destroy()

  serialize: ->
    jokeElegantViewState: @jokeElegantView.serialize()

  toggle: ->
    console.log 'JokeElegant was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
