describe "jasmine-fixture 2.x", ->

  describe "affix", ->
    beforeEach ->
      jasmineFixture(jQuery_1_6_4)
      this.addMatchers
        toInjectProperly: ->
          $result = affix(this.actual)
          $.contains('body',this.actual) && $result.is(this.actual)

    EXAMPLES = [
      '.foo',
      '.bar',
      '#baz',
      '#foo .panda',
      'input#man .restroom',
      '.pants.zipper',
      'span#spaghetti.sauce',
      # 'article.sauce#spaghetti',
      # 'foo > bar'
      # input[value=12]
      # .sauce:eq(23)
    ]

    _(EXAMPLES).each (selector) ->
      Then -> expect(selector).toInjectProperly()
      Then -> expect($('body')).not.toHas(selector)



    context "chaining", ->
      Given -> @$container = affix('.container')
      When -> @$container.affix('#content')
      Then -> expect(@$container).toHas('#content')