require 'spec_helper'
require 'mail'

def message_to(who)
  Mail::Message.new(:to => "#{who}@otherbox.me")
end

describe EmailInterfaceController do
  describe "routes" do
    it "should recognize summary routes" do
      EmailInterfaceController.recognize_path(message_to("check")).should be
      EmailInterfaceController.recognize_path(message_to("send")).should be
    end
    
    it "should recognize unsub routes" do
      EmailInterfaceController.recognize_path(message_to("unsubscribe")).should be
    end
  end
end

