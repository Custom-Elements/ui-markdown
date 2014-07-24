#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

      setURL: ->
        promiseArray = []
        mdText = ''
        urlList=@urls.split(' ')
        for url in urlList
          console.log url
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
