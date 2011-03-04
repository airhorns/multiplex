require 'spec_helper'

describe EmailInterfaceController do
 
  describe "verbs" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "should send summary jobs" do
      @message = FactoryGirl.create(:message, to_email:"check@otherbox.me", :user => @user)      
      Resque.should_receive(:enqueue).with(MailSummaryJob, @user.id).and_return(true)
      EmailInterfaceController.dispatch(@message)
    end

    it "should unsubscribe from summaries" do
      @message = FactoryGirl.create(:message, to_email:"unsubscribe@otherbox.me", :user => @user)      
      @user.should_receive(:unsubscribe!)
      EmailInterfaceController.dispatch(@message)
    end
    
    it "should error if no user is found attached to the message" do
      @message = FactoryGirl.create(:message, to_email:"unsubscribe@otherbox.me", :user => nil)      
      @user.should_not_receive(:unsubscribe!)
      Resque.should_receive(:enqueue)     
      EmailInterfaceController.dispatch(@message)
    end 
  end
end

