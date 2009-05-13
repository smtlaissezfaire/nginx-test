require File.dirname(__FILE__) + "/spec_helper"

describe "resolving constants" do
  it "should resolve Nginx::Test::Curler" do
    Nginx::Test::Curler
  end
  
  it "should resolve the RedirectMatcher" do
    Nginx::Test::RedirectMatcher
  end
end