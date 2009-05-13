require File.dirname(__FILE__) + "/spec_helper"

module Nginx
  module Test
    describe "version" do
      it "should be at 0.0.1" do
        Nginx::Test::VERSION_STRING.should == "0.0.1"
      end
    end
  end
end