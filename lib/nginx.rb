module Nginx
  module Test
    MAJOR = 0
    MINOR = 0
    TINY  = 1
    
    VERSION_STRING = "#{MAJOR}.#{MINOR}.#{TINY}"
    
    def server
      @server || "http://localhost:4000"
    end

    attr_writer :server

    def get(route)
      @response = Curler.get route, server
    end

    def response
      @response
    end

    def redirect_to(route)
      RedirectMatcher.new(route)
    end
    
    autoload :RedirectMatcher, File.dirname(__FILE__) + "/test/redirect_matcher"
    autoload :Curler,          File.dirname(__FILE__) + "/test/curler"
  end
end
