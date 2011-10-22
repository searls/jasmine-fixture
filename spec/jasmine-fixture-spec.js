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


          it('uses the passed string as its class', function(){
            expect($result).toIs('div.pants');
          });

          it('is contained by the body', function(){
            expect($result).toExist();
          });
        });

        context("provided a config object", function() {
          beforeEach(function() {
            $result = $.jasmine.inject({
              el: 'input',
              cssClass: 'open closed',
              id: 'door',
              text: "oh hai, i'm some <escaped>text</escaped>"
            });
          });

          it("is injected as configured", function() {
            expect($result).toIs('input#door.open.closed');
          });

          it("contains the configured text", function() {
            expect($result.text()).toEqual("oh hai, i'm some <escaped>text</escaped>");
          });
        });

        context("passed a properly quoted 'class' property in the config object", function() {
          beforeEach(function() {
            $result = $.jasmine.inject({ 'class': 'burger' });
          });

          it("applies the css class", function() {
            expect($result).toIs('.burger');
          });
        });

      });

      describe("#configure", function() {
        var $result;
        context("configured custom defaults", function() {
          beforeEach(function() {
            $.jasmine.configure({
              el: 'input',
              cssClass: 'party',
              id: 'frog',
              text: '&&'
            })
          });

          context("and inject is passed nothing", function() {
            beforeEach(function() {
              $result = $.jasmine.inject();
            });
            it("uses those defaults", function() {
              expect($result).toIs('input#frog.party');
            });
            it("even sets the text", function() {
              expect($result.text()).toEqual('&&');
            });
          });

          context("and inject is passed a string", function() {
            beforeEach(function() {
              $result = $.jasmine.inject('sauce');
            });
            it("uses those defaults, but changes the class", function() {

              expect($result).toIs('input#frog.sauce');
            });
            it("even sets the text", function() {
              expect($result.text()).toEqual('&&');
            });
          });

        });

        context("configured that when given a string it should inject the id", function() {
          beforeEach(function() {
            $.jasmine.configure({ defaultAttribute: 'id' });

            $result = $.jasmine.inject('foo');
          });
          xit("sets the id and not the class", function() {
            expect($result).toIs('#foo');
          });
        });

      });

      describe("#restoreDefauls", function() {
        context("injecting elements", function() {
          it("retains the previous configuration, until called", function() {
            var result = $.jasmine.inject();
            expect(result).toIs('input#frog.party');
          });
        });
        context("when called", function() {
          var $result; 

          it("should revert back to the defaults when injecting new items", function() {
            $.jasmine.restoreDefaults(); 
            $result = $.jasmine.inject('cheezburger');
            expect($result).toIs('div.cheezburger');
          });
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
        //see the specRunner HTML for the source to this magic string
        expect(window.jasmineFixture).toEqual("Thing that owned jasmineFixture first");
      });
    });
  };

  itInjectsStuff(jQuery);

  jasmineFixture(jQuery_1_6_4);
  itInjectsStuff(jQuery_1_6_4);
});
