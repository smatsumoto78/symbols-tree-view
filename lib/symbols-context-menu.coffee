{$, $$, View} = require 'atom-space-pen-views'

module.exports =
  class SymbolsContextMenu extends View
    @content: ->
      @div class: 'symbols-context-menu', =>
        @div class: 'select-list popover-list', =>
          @input type: 'text', class: 'hidden-input', outlet: 'hiddenInput'
          @ol class: 'list-group mark-active', outlet: 'menus'

    initialize: ->
      @hiddenInput.on 'focusout', =>
        @detach()

    clear: ->
      @menus.empty()

    addMenu: (name, active, callback) ->
      menu = $$ ->
        @li class: (if active then 'active' else ''), name

      menu.on 'mousedown', =>
        menu.toggleClass('active')
        @hiddenInput.blur()
        callback(name)

      @menus.append(menu)

    attach: ->
      if @menus.children().length > 0
        atom.views.getView(atom.workspace).appendChild(@element)
        @hiddenInput.focus()
