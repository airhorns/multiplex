require "spec_helper"

describe MessagesController do
  describe "routing" do

    it "recognizes and generates #sendgrid_create" do
      { :post => "/messages/sendgrid_create" }.should route_to(:controller => "messages", :action => "sendgrid_create")
    end

    it "recognizes and generates #cloudmailin_create" do
      { :post => "/messages/cloudmailin_create" }.should route_to(:controller => "messages", :action => "cloudmailin_create")
    end

    it "recognizes and generates #show" do
      { :get => "/messages/1/deliver" }.should route_to(:controller => "messages", :action => "deliver", :id => "1")
    end
  end
end
