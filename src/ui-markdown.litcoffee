#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'
    promise = require 'promise'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers
      
      mdText: ''
      sections: 0

##Methods

      setURL: ->
        urlList=@urls.split(' ')
        @sections=urlList.length
        for url in urlList
          console.log url
          @makeCall(url).then (text) =>
            @setText(text)

      makeCall: (url) ->
        new Promise (resolve, reject) =>
          @$.xhr.request
            url: url
            callback: (response) ->
              resolve response

      setText: (text) ->
        @sections--
        @mdText+=marked(text)
        if @sections is 0
          @getHTML()

      getHTML: () ->
        @$.el.innerHTML = @mdText

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @setURL()
