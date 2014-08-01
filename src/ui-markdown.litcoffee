#ui-markdown-layout
Renders markdown into HTML content based on markdown source text provided
in the light dom.

    marked = require 'marked'
    _ = require 'lodash'
    bonzo = require 'bonzo'

    Polymer 'ui-markdown',

##Events
###changed
Fired when light dom source markdown is updated.

##Attributes and Change Handlers

##Methods

      clearMarkdown: ->
        bonzo(@querySelectorAll('section[rendered]')).remove()

      bindMarkdown: (markdown) ->
        content = marked @trimIndents(markdown)
        bonzo(@).append "<section rendered>#{content}</section>"
        @fire 'changed'

###trimIndents
The goal here is to find the indent on the first line, then trim off similar
leading indentation on the remaining lines.

      trimIndents: (text) ->
        textComponents = text.split(/[\n]+/)
        trimmedTextComponents = []
        firstLineOffset = null
        for textComponent in textComponents
          if textComponent.length > 0
            if !firstLineOffset?
              firstLineOffset = textComponent.length-textComponent.trimLeft().length
            trimmedTextComponents.push textComponent.substr(firstLineOffset,textComponent.length)
        return trimmedTextComponents.join('\n')

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        render = =>
          @clearMarkdown()
          @bindMarkdown @textContent
          @onMutation @, render
        render()
