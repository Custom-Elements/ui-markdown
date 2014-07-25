#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'
    Promise = require('es6-promise').Promise

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

      checkForNoCyclicDependencies: (url) ->
        urlArray = []
        els = document.querySelectorAll('ui-markdown::shadow #el')
        for el in els
          testUrl = el.getAttribute('url')
          if not testUrl?
            el.setAttribute('url', url)
          else
            urlArray.push(testUrl)
        for checkUrl in urlArray
          if checkUrl is url
            console.log 'cyclic dependency reference with url: ' + url
            return false
        return true

      setURL: ->
        promiseArray = []
        mdText = ''
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
        @$.el.innerHTML = mdText

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @setURL()
