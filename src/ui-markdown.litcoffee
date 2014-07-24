#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'
    promise = require 'promise'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers
      
      mdText: ''
      promiseArray: []

##Methods

      setURL: ->
        urlList=@urls.split(' ')
        for url in urlList
          console.log url
          @promiseArray.push(@makeCall(url))
        @getPromise().then (responseArray) =>
          for response in responseArray
            @setText(response)
          @getHTML()

      getPromise: ->
        Promise.all(@promiseArray)

      makeCall: (url) ->
        new Promise (resolve, reject) =>
          @$.xhr.request
            url: url
            callback: (response) ->
              resolve response

      setText: (response) ->
        @mdText+=marked(response)

      getHTML: () ->
        @$.el.innerHTML = @mdText

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @setURL()
