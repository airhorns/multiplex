require "spec_helper"

describe DeliveryManifestsController do
  describe "routing" do

    it "recognizes and generates #update for get and post" do
      { :get => "/delivery_manifests/1" }.should route_to(:controller => "delivery_manifests", :action => "update", :id => "1")
      { :put => "/delivery_manifests/1" }.should route_to(:controller => "delivery_manifests", :action => "update", :id => "1")
    end
  end
end

