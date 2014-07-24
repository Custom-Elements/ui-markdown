#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers
      
      mdText: ''
      sections: 0

##Methods

      setURL: ->
        urlList=@urls.split(' ')
        @sections=urlList.length
        console.log @sections
        for url in urlList
          console.log url
          @$.ajax.url=url
          @$.ajax.go()
        

      setText: (evt) ->
        console.log evt
        @sections--
        @mdText+=marked(evt.detail.response)
        if @sections is 0
          @getHTML()

      getHTML: () ->
        @$.el.innerHTML = @mdText

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @setURL()
