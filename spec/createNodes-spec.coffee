describe "jasmine-fixture", ->

  describe "createNodes", ->

    for selector in EXAMPLES
      do (selector) ->
        Given "#{selector} is created", ->
          @$result = $(window).createNodes(selector)
        Then "#{selector} exists but is not added to the DOM", ->
          expect(@$result.length).toBeGreaterThan(0)
          expect(@$result.parent().length).toEqual(0)
          expect($('body')).not.toHas(selector)

    context "a plain old div", ->
      Given -> @$result = $(window).createNodes('div')
      Then -> expect(@$result).toIs('div')

    context "raw attrs", ->
      Given -> @$result = $(window).createNodes('[name=foo]')
      Then -> expect(@$result).toIs('[name=foo]')

    context "nesting returns", ->
      Given -> @$result = $(window).createNodes('table.sp_record tbody tr')
      Then -> expect(@$result).toIs('table')

    context "a siblings!", ->
      Given -> @$result = $(window).createNodes('div h1+h2')
      Then -> expect(@$result.find('h1').siblings('h2')).toIs("h2")

    context "chaining", ->
      Given -> @$container = $(window).createNodes('.container')
      When -> @$result = @$container.affix('#content')
      Then -> expect(@$container).toHas('#content')
      Then -> expect(@$result).toIs('#content')