JokeElegantView = require './jk-elegant-view'
{CompositeDisposable} = require 'atom'

module.exports = JokeElegant =
  jokeElegantView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    console.log 'activate now!'
    @jokeElegantView = new JokeElegantView(state.jokeElegantViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @jokeElegantView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'jk-elegant:toggle': => @toggle()
      'jk-elegant:elegantify': => @elegantify()

  deactivate: ->
    console.log 'deactivate now!'
    @modalPanel.destroy()
    @subscriptions.dispose()
    @jokeElegantView.destroy()

  serialize: ->
    console.log 'serialize now!'
    jokeElegantViewState: @jokeElegantView.serialize()

  toggle: ->
    console.log 'JokeElegant was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      wordsLength = editor.getText().split(/\s+/).length
      @jokeElegantView.setCount(wordsLength)

      @modalPanel.show()

  elegantify: ->
    console.log 'Hello! I\'m Elegantify!'
    console.log 'getElementById getElementsByClass element elements eleEle ele1 @Ele'
    editor = atom.workspace.getActiveTextEditor()

    editorStrings  = editor.getText();
    elegantStrings = editorStrings.replace( /(E|e)lement(s?)/g , "$1legant$2" );
    elegantStrings = elegantStrings.replace( /(E|e)le([^a-z])/g , "$1legant$2" );
    elegantStrings = elegantStrings.replace( /(E|e)le([^a-z])/g , "$1legant$2" );
    editor.setText(elegantStrings);
