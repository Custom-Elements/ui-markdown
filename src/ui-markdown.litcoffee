#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'
    Promise = require('es6-promise').Promise

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

      getNextHigherLevelHost: (element) ->
        if element is null
          return null
        else if element.nodeName is "#document-fragment"
          return element.host
        else
          return @getNextHigherLevelHost(element.parentNode)

      getHigherLevelUrls: (urls, element) ->
        element = @getNextHigherLevelHost element
        if element is null
          return urls
        else
          urlString = element.getAttribute 'urls'
          urls = urls.concat urlString.split(' ')
          return @getHigherLevelUrls urls, element

      checkForNoCyclicDependencies: (url) ->
        element = @
        urls = @getHigherLevelUrls [], element

        for checkUrl in urls
          if checkUrl is url
            console.log 'cyclic dependency reference with url: ' + url
            return false
        return true

      setURL: ->
        promiseArray = []
        mdText = ''
        if @urls
          urlList=@urls.split(' ')
          for url in urlList
            if @checkForNoCyclicDependencies(url)
              promiseArray.push(@makeCall(url))
          Promise.all(promiseArray).then (responseArray) =>
            for response in responseArray
              mdText+=marked(response)
            @getHTML(mdText)

      makeCall: (url) ->
        new Promise (resolve, reject) =>
          @$.xhr.request
            url: url
            callback: (response) ->
              resolve response

      getHTML: (mdText) ->
        @$.el.innerHTML += mdText

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        offset = this.innerHTML.length - this.innerHTML.trimLeft().length
        @getHTML marked(this.innerHTML.trimLeft())
        @setURL()
