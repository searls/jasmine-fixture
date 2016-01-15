(($, emmet) ->
  root = `(1, eval)('this')`

  originalJasmineFixture = root.jasmineFixture
  originalJasmineDotFixture = root.jasmine?.fixture
  originalAffix = root.affix
  removeEmmetGlobal = (->
    delete root.emmet
    if root.hasOwnProperty('__jasmineFixtureEmmetNoConflict')
      root.emmet = root.__jasmineFixtureEmmetNoConflict
      delete root.__jasmineFixtureEmmetNoConflict
  )()


  _ = (list) ->
    inject: (iterator, memo) ->
      memo = iterator(memo, item) for item in list

  root.jasmineFixture = ($) ->
    affix = (selectorOptions) ->
      create.call(this, selectorOptions, true)

    create = (selectorOptions, attach) ->
      $top=null
      _(selectorOptions.trim().split(/[ ](?![^\{]*\})(?=[^\]]*?(?:\[|$))/)).inject(($parent, elementSelector) ->
        return $parent if elementSelector == ">"
        $el = $(emmet.parser.expand(elementSelector))
        $el.appendTo($parent) if attach || $top
        $top ||= $el
        $el
      , $whatsTheRootOf(@))
      $top

    noConflict = ->
      currentJasmineFixture = jasmine.fixture
      root.jasmineFixture = originalJasmineFixture
      root.jasmine?.fixture = originalJasmineDotFixture
      root.affix = originalAffix
      currentJasmineFixture

    $whatsTheRootOf = (that) ->
      if that?.jquery?
        that
      else if $('#jasmine_content').length > 0
        $('#jasmine_content')
      else
        $('<div id="jasmine_content"></div>').appendTo('body')

    ewwSideEffects = (jasmineFixture) ->
      root.jasmine?.fixture = jasmineFixture
      $.fn.affix = root.affix = jasmineFixture.affix
      afterEach ->
        $('#jasmine_content').remove()

    jasmineFixture = {affix, create, noConflict}
    ewwSideEffects(jasmineFixture)
    return jasmineFixture


  if $
    jasmineFixture = root.jasmineFixture($)
  else
    root.affix = ->
      nowJQueryExists = window.jQuery || window.$
      if nowJQueryExists?
        jasmineFixture = root.jasmineFixture(nowJQueryExists)
        affix.call(this, arguments...)
      else
        throw new Error("jasmine-fixture requires jQuery to be defined at window.jQuery or window.$")

)(window.jQuery || window.$, emmet)

