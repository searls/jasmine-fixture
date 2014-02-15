describe "jasmine-fixture", ->

  EXAMPLES = [
     'article'                                                             #<article></article>
     '.foo'                                                                #<div class="foo"></div>
     '.foo-hah'                                                            #<div class="foo-hah"></div>
     '#blah-blah'                                                          #<div id="blah-blah"></div>
     '#baz'                                                                #<div id="baz"></div>
     'h1.foo'                                                              #<h1 class="foo"></h1>
     'h2#baz'                                                              #<h2 id="baz"></h2>
     'h3#zing.zoom'                                                        #<h3 id="zing" class="zoom"></h3>
     'h4.zoom#zing'                                                        #<h4 id="zing" class="zoom"></h4>
     'div span ul li'                                                      #<div><span><ul><li></li></ul></span></div>
     'a b c d e f g h i j k l m n o p q r s t u v w x y z'                 #<a><b><c><d><e><f><g><h><i><j><k><l><m><n><o><p><q><r><s><t><u><v><w><x><y><z></z></y></x></w></v></u></t></s></r></q></p></o></n></m></l></k></j></i></h></g></f></e></d></c></b></a>
     '.boom.bang.pow#whoosh'                                               #<div id="whoosh" class="boom bang pow"></div>
     '#foo .panda'                                                         #<div id="foo"><div class="panda"></div></div>
     'input#man .restroom'                                                 #<input id="man"></input>
     '.pants.zipper'                                                       #<div class="pants zipper"></div>
     'foo > bar > baz'                                                     #<foo><bar><baz></baz></bar></foo>
     'input[value="12"]'                                                   #<input value="12">
     'div[class="class1 class2 class3"] span[div="div1 div2 div3"]'        #<div class="class1 class2 class3"><span div="div1 div2 div3"></span></div>
     'form fieldset[name=ok] input#foo.sp1.sp1[foo="woo"][value="13"]'     #<form><fieldset name="ok"><input foo="woo" value="13" id="foo" class="sp1 sp1"></fieldset></form>
     '[name="foo"][bar="baz"]'                                             #<name name="foo" bar="baz"></name>
     'div[data-bind="my_item"]'                                            #<div data-bind="my_item"></div>
     '.ui-dialog[style="width: 1px; height: 5px"]'                         #<div style="width: 1px; height: 5px" class="ui-dialog"></div>
     '#toddler .hidden.toy input[name="toyName"][value="cuddle bunny"]'    #<div id="toddler"><div class="hidden toy"><input name="toyName" value="cuddle bunny"></div></div>
     'select[name="date[year]"]'                                           #<select name="date[year]"></select>
  ]

  describe "affix", ->

    for selector in EXAMPLES
      do (selector) ->
        Then "#{selector} is added to the DOM", -> expect(selector).toInjectProperly()
        Then "#{selector} does not pollute the DOM", -> expect($('body')).not.toHas(selector) #<--ensure no pollution is happening

    context "non-ids with hash symbol", ->
      Given -> affix('a[data-target-pane="#pane-id"]')
      Then -> expect($('body')).not.toHas('#pane-id')
  
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
