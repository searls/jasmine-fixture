describe('Jasmine Fixture',function(){
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
  
});