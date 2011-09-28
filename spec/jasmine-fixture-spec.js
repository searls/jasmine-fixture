window.context = window.describe;
window.xcontext = window.xdescribe;

describe('Jasmine Fixture',function(){
  var itInjectsStuff = function($) {
    it('is named $.jasmine',function(){
      expect($.jasmine).toBeDefined();
    });

    describe('#inject',function(){
      var result;
      beforeEach(function(){
        result = $.jasmine.inject('<div class="pants"></div>');
      });
      it('returns the injected HTML as a jQuery result',function(){
        expect(result.hasClass('pants')).toBe(true);
      });
    })

    it("tidies up (the page no longer contains the injected content on the page)", function() {
      expect($('.pants').length).toBe(0);
    });

    describe("#noConflict", function() {
      var subject,noConflicted,cachedCopy;
      beforeEach(function() {
        cachedCopy = window.jasmineFixture;

        subject = window.jasmineFixture($)
        noConflicted = subject.noConflict();
      });

      afterEach(function() {
        window.jasmineFixture = cachedCopy;
      });

      it("returns itself when noConflicted", function() {
        expect(subject).toBe(noConflicted);
      });

      it("returns control of jasmineFixture to the thing that owned it first", function() {
        //see the specRunner for the source to this magic string
        expect(window.jasmineFixture).toEqual("Thing that owned jasmineFixture first");
      });
    });
  };

  itInjectsStuff(jQuery);

  jasmineFixture(jQuery_1_6_4);
  itInjectsStuff(jQuery_1_6_4);
});