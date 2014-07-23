#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

      getMD: ->
        @$.ajax.url='../README.md'
        @$.ajax.go()

      getHTML: (evt) ->
        @$.el.innerHTML = marked(evt.detail.response)

##Event Handlers

##Polymer Lifecycle

      ready: () ->
        @getMD()
