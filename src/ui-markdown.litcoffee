#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

      ajaxHandler: (event, data) ->
        if @checkForNoCyclicDependencies @url, @
          @bindMarkdown data.response

      observe:
        '$.markdown.innerHTML': 'innerHTMLChanged'

      innerHTMLChanged: (oldValue, newValue) ->
        @bindMarkdown @trimIndents(newValue)

      bindMarkdown: (markdown) ->
          @$.markdown.innerHTML = marked markdown

      getHost: (element) ->
        if element is null
          return null
        else if element.nodeName is "#document-fragment"
          return element.host
        else
          return @getHost element.parentNode

      checkForNoCyclicDependencies: (testUrl, element) ->
        hostElement = @getHost element
        if hostElement isnt null
          hostUrl = hostElement.getAttribute 'url'
          if testUrl is hostUrl
            console.log('hi')
            return false
          else if hostElement.parentNode?
            return @checkForNoCyclicDependencies testUrl, hostElement
          else
            return true
        return true

      trimIndents: (text) ->
        textComponents = text.split(/[\n\r]+/)
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
        @bindMarkdown @trimIndents(this.textContent)
