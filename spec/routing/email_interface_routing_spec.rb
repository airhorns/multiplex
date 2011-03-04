require "spec_helper"

def message_to(who)
  FactoryGirl.build(:message, to_email:"#{who}@#{Multiplex::Application::Domain}", user:nil)
end

describe EmailInterfaceController do
  describe "routing" do
    it "should recognize summary routes" do
      EmailInterfaceController.recognize_path(message_to("check")).should be
      EmailInterfaceController.recognize_path(message_to("send")).should be
    end
    
    it "should recognize unsub routes" do
      EmailInterfaceController.recognize_path(message_to("unsubscribe")).should be
    end
  end
end
