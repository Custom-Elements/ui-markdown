#ui-markdown-layout
Renders markdown into HTML content based on markdown source text provided
in the light dom.

    marked = require 'marked'

Customized rendering.

    renderer = new marked.Renderer()
    renderer.code = (code, language) ->
      "<ui-code language='#{language}'>#{code}</ui-code>"
    renderer.listitem = (text) ->
      "<li dotted>#{text}</li>"
    Polymer 'ui-markdown',

##Events
###changed
Fired when light dom source markdown is updated.

##Attributes and Change Handlers
###value
This is an alternate to putting inline content, useful for data binding.

      valueChanged: ->
        @render()

##Methods

      clearMarkdown: ->
        rendered = @querySelector 'section[rendered]'
        rendered?.parentNode?.removeChild rendered

      bindMarkdown: (markdown) ->
        content = marked @trimIndents(markdown), renderer: renderer
        rendered = document.createElement 'section'
        rendered.setAttribute 'rendered', ''
        rendered.innerHTML = content
        @appendChild rendered
        @fire 'changed'

      render: ->
        @clearMarkdown()
        @bindMarkdown @value or @textContent

###trimIndents
The goal here is to find the indent on the first line, then trim off similar
leading indentation on the remaining lines.

      trimIndents: (text) ->
        lines = text.split(/[\n]/)
        trimmedTextComponents = []
        for line in lines
          if line.trim().length > 0 and not firstLineOffset?
            firstLineOffset = line.length-line.trimLeft().length
          trimmedTextComponents.push line.substr(firstLineOffset)
        trimmedTextComponents.join('\n')

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @onMutation @$.markdown, @render
        @render()
