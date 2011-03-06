require 'spec_helper'

describe EmailInterfaceController do

  describe "verbs" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "should send summary jobs" do
      @message = FactoryGirl.create(:message, to_email:"check@#{Multiplex::Application::Domain}", :user => @user)
      Resque.should_receive(:enqueue).with(MailSummaryJob, @user.id).and_return(true)
      EmailInterfaceController.dispatch(@message)
    end

    it "should unsubscribe from summaries" do
      @message = FactoryGirl.create(:message, to_email:"unsubscribe@#{Multiplex::Application::Domain}", :user => @user)
      @user.should_receive(:unsubscribe!)
      EmailInterfaceController.dispatch(@message)
    end

    it "should error if no user is found attached to the message" do
      @message = FactoryGirl.create(:message, to_email:"unsubscribe@#{Multiplex::Application::Domain}", :user => nil)
      @user.should_not_receive(:unsubscribe!)
      Resque.should_receive(:enqueue)
      EmailInterfaceController.dispatch(@message)
    end

    it "should error if an unrecognized path is dispatched" do
      @message = FactoryGirl.create(:message, to_email:"something@#{Multiplex::Application::Domain}", :user => nil)
      Resque.should_not_receive(:enqueue)
      expect { EmailInterfaceController.dispatch(@message) }.to raise_error(EmailInterfaceController::UnrecognizedPathError)
    end

    describe "confirmations" do
      it "shold allow unconfirmed users to email from their own address, and confirm them" do
        @message = FactoryGirl.create(:message, to_email:"check@#{Multiplex::Application::Domain}", :user => @user)
        @user.confirmed_at = nil
        @user.should_receive(:confirm!)
        Resque.should_receive(:enqueue)
        EmailInterfaceController.dispatch(@message)
      end
    end
  end
end

