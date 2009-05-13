require "uri"

module Nginx
  module Test
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
  end
end