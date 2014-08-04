#ui-markdown-layout
Renders markdown into HTML content based on markdown source text provided
in the light dom.

    marked = require 'marked'
    _ = require 'lodash'
    bonzo = require 'bonzo'

Customized rendering.

    renderer = new marked.Renderer()
    renderer.code = (code, language) ->
      "<ui-code language='#{language}'>#{code}</ui-code>"
    renderer.codespan = (code) ->
      "<ui-code inline>#{code}</ui-code>"

    Polymer 'ui-markdown',

##Events
###changed
Fired when light dom source markdown is updated.

##Attributes and Change Handlers

##Methods

      clearMarkdown: ->
        bonzo(@querySelectorAll('section[rendered]')).remove()

      bindMarkdown: (markdown) ->
        content = marked @trimIndents(markdown), renderer: renderer
        bonzo(@).append "<section rendered>#{content}</section>"
        @fire 'changed'

###trimIndents
The goal here is to find the indent on the first line, then trim off similar
leading indentation on the remaining lines.

      trimIndents: (text) ->
        lines = text.split(/[\n]/)
        trimmedTextComponents = []
        for line in lines
          console.log line
          if line.trim().length > 0 and not firstLineOffset?
            firstLineOffset = line.length-line.trimLeft().length
            console.log firstLineOffset
          trimmedTextComponents.push line.substr(firstLineOffset)
        trimmedTextComponents.join('\n')

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        render = =>
          @clearMarkdown()
          @bindMarkdown @textContent
          @onMutation @, render
        render()
