describe "jasmine-fixture 2.x", ->

  describe "affix", ->
    beforeEach ->
      jasmineFixture(jQuery_1_6_4)
      this.addMatchers
        toInjectProperly: ->
          $result = affix(this.actual)
          $(this.actual).length > 0 and $result.is(this.actual)

    EXAMPLES = [
      '.foo'
      '.bar'
      '#baz'
      'h1'
      'div b'
      'a b c d e f g h i j k l m n o p q r s t u v w x y z'
      '.boom.bang.pow#whoosh'
      '#foo .panda'
      'input#man .restroom'
      '.pants.zipper'
      'span#spaghetti.sauce'
      'article.sauce#spaghetti'
      'foo > bar'
      'input[value="12"]'
      'input#foo.sp1.sp1[value="13"]'
    ]

    _(EXAMPLES).each (selector) ->
      Then -> expect(selector).toInjectProperly()
      Then -> expect($('body')).not.toHas(selector)

    context "a plain old div", ->
      Given -> @$result = affix('div')
      Then -> expect(@$result).toIs('div')
    context "chaining", ->
      Given -> @$container = affix('.container')
      When -> @$container.affix('#content')
      Then -> expect(@$container).toHas('#content')