require "spec_helper"

describe DashboardController do
  describe "routing" do

    it "recognizes and generates #faq" do
      { :get => "/faq" }.should route_to(:controller => "dashboard", :action => "faq")
    end

    it "recognizes and generates #help" do
      { :get => "/help" }.should route_to(:controller => "dashboard", :action => "help")
    end

    it "recognizes and generates #about" do
      { :get => "/about" }.should route_to(:controller => "dashboard", :action => "about")
    end
    
  end
end


