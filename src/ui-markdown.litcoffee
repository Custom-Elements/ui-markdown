#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

      url: ''

##Methods

      getMD: ->
        @$.ajax.url=@url
        @$.ajax.go()

      getHTML: (evt) ->
        @$.el.innerHTML = marked(evt.detail.response)

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @getMD()
