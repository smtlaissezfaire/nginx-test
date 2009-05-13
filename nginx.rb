module Nginx
  module Test
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
    
    autoload :RedirectMatcher, "test/redirect_matcher"
    autoload :Curler,          "test/curler"
  end
end
