
class FriendlyDigest < String
  class << self
    def [](*p) ; new(*p) ; end
    
    def codes
      @codes ||= ['Z','2','B','T','C','9','H','Q','V','K','N','W','7','P','4','J','Y','G','E','A','D','3','F','8','M','X','6','U','R']
    end
    
    def decode(input)
      input.strip.upcase.split('').inject(0) {|tot,c| (tot * codes.length) + codes.index(c) }
    end
  end

  def initialize(input)
    output = input == 0 ? [self.class.codes.first] : []
    while input > 0
      rem = input % self.class.codes.length
      input = (input - rem) / self.class.codes.length #/
      output << self.class.codes[rem]
    end
    output.reverse.each {|c| self << c }
  end
end
