#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

      getNextHigherLevelHost: (element) ->
        if element is null return null
        else if element.nodeName is "#document-fragment" return element.host
        else return @getNextHigherLevelHost element.parentNode

      getHigherLevelUrls: (urls, element) ->
        element = @getNextHigherLevelHost element
        if element is null return urls
        else
          urlString = element.getAttribute 'urls'
          urls = urls.concat urlString.split ' '
          return @getHigherLevelUrls urls, element

      checkForNoCyclicDependencies: (url) ->
        url = @getHigherLevelUrls [], @
        for checkUrl in urls
          if checkUrl is url
            console.log 'cyclic dependency reference with url: ' + url
            return false
        return true

      trimIndents: (text) ->
        offset = text.length - text.trimLeft().length
        extraWhitespace = this.innerHTML.substr 0, offset
        return text.replace(extraWhitespace,'','g')

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        trimmedMarkdown = @trimIndents this.innerHTML
        @markdown = marked trimmedMarkdown
