require "net/http"

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

    class RedirectMatcher
      def initialize(expected)
        @expected = expected
      end

      def matches?(response)
        uri = URI.parse(response.redirect_url)
        @given = uri.path
      
        @expected == @given
      end
    
      def failure_message
        "Expected route '#{@expected}' to match given route '#{@given}'"
      end
    end

    class Curler
      def self.get(route, server)
        obj = new(server)
        obj.get(route)
        obj.response
      end

      def initialize(server)
        @server = server
      end

      def get(route)
        uri = URI.parse(@server)
        http = Net::HTTP.new(uri.host, uri.port)
        @output = http.request_head route
      end

      def response
        Response.new(@output)
      end

      class Response
        def initialize(output)
          @output = output
        end

        def success?
          @output.is_a?(Net::HTTPOK)
        end

        def redirect?
          @output.is_a?(Net::HTTPRedirection)
        end

        def permanent_redirect?
          @output.is_a?(Net::HTTPMovedPermanently)
        end

        def redirect_url
          @output['location']
        end
      end
    end
  end
end
