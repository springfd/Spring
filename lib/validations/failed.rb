module Validations
  class Validations::Failed < StandardError
    attr_reader :args
  
    def initialize(args)
      @args=args
    end    
  end
end