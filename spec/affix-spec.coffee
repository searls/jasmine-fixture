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
      'form fieldset[name="ok"] input#foo.sp1.sp1[foo="woo"][value="13"]'
      '[name="foo"][bar="baz"]'
    ]

    _(EXAMPLES).each (selector) ->
      Then -> expect(selector).toInjectProperly()
      Then -> expect($('body')).not.toHas(selector)

    context "a plain old div", ->
      Given -> @$result = affix('div')
      Then -> expect(@$result).toIs('div')

    context "multiple attrs", ->
      Given -> @$result = affix('[name="foo"][bar="baz"]')
      Then -> expect($('body')).toHas('[name="foo"][bar="baz"]')
      Then -> expect(@$result).toIs('[name="foo"][bar="baz"]')

    context "chaining", ->
      Given -> @$container = affix('.container')
      When -> @$container.affix('#content')
      Then -> expect(@$container).toHas('#content')