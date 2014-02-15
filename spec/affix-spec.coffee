describe "jasmine-fixture", ->

  describe "affix", ->

    for selector in EXAMPLES
      do (selector) ->
        Then "#{selector} is added to the DOM", -> expect(selector).toInjectProperly()
        Then "#{selector} does not pollute the DOM", -> expect($('body')).not.toHas(selector) #<--ensure no pollution is happening

    context "non-ids with hash symbol", ->
      Given -> affix('a[data-target-pane="#pane-id"]')
      Then -> expect($('body')).not.toHas('#pane-id')
