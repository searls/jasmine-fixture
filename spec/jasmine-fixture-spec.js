window.context = window.describe;
window.xcontext = window.xdescribe;

beforeEach(function() {
  this.addMatchers({
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
    }
  });
});

describe('Jasmine Fixture',function(){
  var itInjectsStuff = function($) {

    describe("$.jasmine", function() {
      it('is named $.jasmine',function(){
        expect($.jasmine).toBeDefined();
      });

      describe('#inject',function(){
        var $result;

        context('provided an HTML string', function(){
          beforeEach(function(){
           $result = $.jasmine.inject('<div class="pants"></div>');
          });

          it('returns the injected HTML as a jQuery result',function(){
            expect($result).toIs('div.pants');
          });
        });

        context('provided a string argument', function(){
          beforeEach(function(){
            $result = $.jasmine.inject('pants');
          });

          it('is a div',function(){
            expect($result).toIs('div')
          });

          it('uses the passed string as its class', function(){
            expect($result).toIs('.pants');
          });

          it('is contained by the body', function(){
            expect($result).toExist();
          });
        });

        xcontext("provided a config object", function() {
          beforeEach(function() {
            $result = $.jasmine.inject({
              el: 'input',
              cssClass: 'open closed',
              id: 'door'
            });
          });

          it("is of the specified element type", function() {
            expect($result).toIs('input');
          });


        });
      });

      describe("#config", function() {
        context("configuring 'span' as the default injected element", function() {

        });

        context("configuring 'id' as the default attribute", function() {

        });
      });
    });

    describe("$.fn.inject",function(){
      var $container,$result;
      beforeEach(function(){
        $container = $.jasmine.inject('phone');

        $result = $container.inject('fax');
      });

      it('appends the injected as a child of the container',function(){
        expect($container).toHas('.fax');
      });

      it('returns the child (even though an idiomatic jQuery function would return the original set)',function(){
        expect($result).toIs('.fax');
      });
    });


    it("afterward, it tidies up (the page no longer contains the injected content on the page)", function() {
      expect('.pants').not.toExist();
    });

    describe("#noConflict", function() {
      var subject,noConflicted,cachedCopy;
      beforeEach(function() {
        cachedCopy = window.jasmineFixture;

        subject = window.jasmineFixture($);

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
