# jasmine-fixture Makes injecting HTML snippets into the DOM easy & clean!
# site: https://github.com/searls/jasmine-fixture
(($) ->
  originalJasmineFixture = window.jasmineFixture
  originalInject = window.inject
  originalAffix = window.affix
  defaultConfiguration =
    el: "div"
    cssClass: ""
    id: ""
    text: ""
    html: ""
    defaultAttribute: "class"
    attrs: {}

  window.jasmineFixture = ($) ->
    #--------------------------------------------------------
    # #affix (jasmine-fixture 2.x)
    $.fn.affix = window.affix = (selectorOptions) ->
      _(selectorOptions.split(' ')).inject(($parent, elementSelector) ->
        elementSplit = elementSelector.split('#')
        elementName = elementSplit[0] if elementSplit.length > 1

        idSplit = if elementSplit.length > 1 then elementSplit[1].split('.') else elementSelector.split('.')
        id = idSplit[0]
        classes = _(idSplit).rest()

        $("<#{elementName || "div"} id=\"#{id}\" class=\"#{classes.join(' ')}\"></div>").appendTo($parent)
      , $whatsTheRootOf(this))

    $whatsTheRootOf = (that) ->
      if that.jquery?
        that
      else if $('#jasmine_content').length > 0
        $('#jasmine_content')
      else
        $('<div id="jasmine_content"></div>').appendTo('body')

    afterEach ->
      $('#jasmine_content').remove()

    #--------------------------------------------------------
    # #inject (jasmine-fixture 1.x)
    isReady = false
    rootId = "specContainer"
    defaults = $.extend({}, defaultConfiguration)
    $.jasmine =
      inject: (arg, context) ->
        init()  if isReady isnt true
        parent = (if context then context else $("#" + rootId))
        $toInject = undefined
        if itLooksLikeHtml(arg)
          $toInject = $(arg)
        else
          config = $.extend({}, defaults, arg,
            userString: arg
          )
          $toInject = $("<" + config.el + "></" + config.el + ">")
          applyAttributes $toInject, config
          injectContents $toInject, config
        $toInject.appendTo parent

      configure: (config) ->
        $.extend defaults, config

      restoreDefaults: ->
        defaults = $.extend({}, defaultConfiguration)

      noConflict: ->
        window.jasmineFixture = originalJasmineFixture
        window.inject = originalInject
        window.affix = originalAffix
        this

    $.fn.inject = (html) ->
      $.jasmine.inject html, $(this)

    applyAttributes = ($html, config) ->
      attrs = $.extend({},
        id: config.id
        class: config["class"] or config.cssClass
      , config.attrs)
      attrs[config.defaultAttribute] = config.userString  if isString(config.userString)
      for key of attrs
        $html.attr key, attrs[key]  if attrs[key]

    injectContents = ($el, config) ->
      if config.text and config.html
        throw "Error: because they conflict, you may only configure inject() to set `html` or `text`, not both! \n\nHTML was: " + config.html + " \n\n Text was: " + config.text
      else if config.text
        $el.text config.text
      else $el.html config.html  if config.html

    itLooksLikeHtml = (arg) ->
      isString(arg) and arg.indexOf("<") isnt -1

    isString = (arg) ->
      arg and arg.constructor is String

    init = ->
      $("body").append "<div id=\"" + rootId + "\"></div>"
      isReady = true

    tidyUp = ->
      $("#" + rootId).remove()
      isReady = false

    $(($) -> init())

    afterEach ->
      tidyUp()

    $.jasmine

  if $
    jasmineFixture = window.jasmineFixture($)
    window.inject = window.inject or jasmineFixture.inject
) jQuery