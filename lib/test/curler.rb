require "net/http"

module Nginx
  module Test
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

        def found?
          !@output.is_a?(Net::HTTPNotFound)
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
