#ui-markdown-layout
Layout with converted markdown

    marked = require 'marked'

    Polymer 'ui-markdown',

##Events

##Attributes and Change Handlers

##Methods

##Event Handlers

##Polymer Lifecycle

      created: ->

      ready: () ->
        @$.el.innerHTML = marked('asdf')
