{CompositeDisposable} = require 'atom'

module.exports = JokeElegant =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'jk-elegant:elegantify': => @elegantify()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  elegantify: ->
    console.log 'Hello! I\'m Elegantify!'
    editor = atom.workspace.getActiveTextEditor()

    editorStrings  = editor.getText()
    elegantStrings = editorStrings.replace(  /(E|e)lement(s?)/g , "$1legant$2" )
    elegantStrings = elegantStrings.replace( /(E|e)le([^a-z])/g , "$1legant$2" )
    elegantStrings = elegantStrings.replace( /(E|e)le([^a-z])/g , "$1legant$2" )
    editor.setText(elegantStrings)
