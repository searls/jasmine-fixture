describe("#noConflict", function() {
  var subject,noConflicted,cache;
  beforeEach(function() {
    cache = {
      jasmineFixture: window.jasmineFixture,
      affix: window.affix,
      jasmineDotFixture: jasmine.fixture
    };

    subject = window.jasmineFixture($);

    noConflicted = subject.noConflict();
  });

  afterEach(function() {
    window.jasmineFixture = cache.jasmineFixture;
    window.affix = cache.affix;
    jasmine.fixture = cache.jasmineDotFixture;
  });

  it("returns itself when noConflicted", function() {
    expect(subject).toBe(noConflicted);
  });

  it("returns control of jasmineFixture to the thing that owned it first", function() {
    //see the specRunner HTML for the source to this magic string
    expect(window.jasmineFixture).toEqual("Thing that owned jasmineFixture first");
  });

  it("clears window.inject", function() {
    expect(window.inject).not.toBeDefined();
  });

  it("clears window.affix", function() {
    expect(window.affix).not.toBeDefined();
  });
});
