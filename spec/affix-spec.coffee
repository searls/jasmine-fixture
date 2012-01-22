describe "jasmine-fixture 2.x", ->

  describe "affix", ->
    beforeEach ->
      jasmineFixture(jQuery_1_6_4)
      this.addMatchers
        toInjectProperly: ->
          $result = affix(this.actual)
          $(this.actual).length > 0 and $result.is(this.actual)

    EXAMPLES = [
      'span'
      '.foo'
      '#baz'
      'h1.foo'
      'h2#baz'
      'h3#zing.zoom'
      'h4.zoom#zing'
      'div span ul li'
      'a b c d e f g h i j k l m n o p q r s t u v w x y z'
      '.boom.bang.pow#whoosh'
      '#foo .panda'
      'input#man .restroom'
      '.pants.zipper'
      'foo > bar > baz'
      'input[value="12"]'
      'div[class="class1 class2 class3"] span[div="div1 div2 div3"]'
      'form fieldset[name=ok] input#foo.sp1.sp1[foo="woo"][value="13"]'
      '[name="foo"][bar="baz"]'
    ]

    _(EXAMPLES).each (selector) ->
      Then -> expect(selector).toInjectProperly()
      Then -> expect($('body')).not.toHas(selector)

    context "a plain old div", ->
      Given -> @$result = affix('div')
      Then -> expect(@$result).toIs('div')

    context "raw attrs", ->
      Given -> @$result = affix('[name=foo]')
      Then -> expect($('body')).toHas('[name=foo]')
      Then -> expect(@$result).toIs('[name=foo]')

    context "chaining", ->
      Given -> @$container = affix('.container')
      When -> @$container.affix('#content')
      Then -> expect(@$container).toHas('#content')