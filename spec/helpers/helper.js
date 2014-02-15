var root = this;

root.context = root.describe;
root.xcontext = root.xdescribe;

var matchers = {
  toIs: function(selector) {
    return this.actual.is(selector);
  },
  toHas: function(selector) {
    return this.actual.find(selector).length > 0;
  },
  toExist: function() {
    if(this.actual.constructor === String) {
      return $(this.actual).length > 0;
    } else {
      return $.contains(document.body,$(this.actual)[0]);
    }
  },
  toInjectProperly: function() {
    $result = affix(this.actual)
    return $(this.actual).length > 0 && $('#jasmine_content').find(this.actual).length > 0
  }
};

beforeEach(function() {
  if(jasmine.addMatchers) {
    jasmine.addMatchers(jasmine.matcherWrapper.wrap(matchers))
  } else {
    this.addMatchers(matchers)
  }
});

