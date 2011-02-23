
class FriendlyDigest < String
  class InvalidInputException < Exception ; end
  class << self
    def [](*p) ; new(*p) ; end
    
    def codes
      @codes ||= ['Z','2','B','T','C','9','H','Q','V','K','N','W','7','P','4','J','Y','G','E','A','D','3','F','8','M','X','6','U','R']
    end
    
    def numcodes
      @numcodes ||= codes.length
    end
    
    def decode(input, parity=false)
      cleaned = input.strip.upcase.split('')
      raise InvalidInputException.new "Invalid character" if cleaned.any?(&:nil?)
      raise InvalidInputException.new "Invalid input" if parity && cleaned.pop!= checksum(cleaned)
      
      cleaned.map {|c| codes.index(c) }.inject(0) {|tot,c| (tot * numcodes) + c }
    end
    
    def checksum(array)
      codes[array.inject(0) {|sum,c| (sum + codes.index(c)) % numcodes }]
    end
  end

  def initialize(input, parity=false)
    output = input == 0 ? [self.class.codes.first] : []
    while input > 0
      rem = input % self.class.codes.length
      input = (input - rem) / self.class.numcodes #/
      output << self.class.codes[rem]
    end
    output.reverse.each {|c| self << c }
    self << self.class.checksum(output) if parity
  end
  
  
end
