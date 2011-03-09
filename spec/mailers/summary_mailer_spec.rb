require "spec_helper"

describe SummaryMailer do
  describe "unsubscribe links" do
    it "should contain an unsub link when messaging a summary" do
      manifest = FactoryGirl.create(:delivery_manifest)
 
      # Send the email, then test that it got queued
      email = SummaryMailer.summary(manifest).deliver
      ActionMailer::Base.deliveries.should_not be_empty
      manifest.user.should be
      email.text_part.to_s.should match(/users\/#{manifest.user.id}\/unsubscribe/)
      email.html_part.to_s.should match(/users\/#{manifest.user.id}\/unsubscribe/)
    end
  end

  describe "summarization" do
    before do 
      @manifest = FactoryGirl.build(:delivery_manifest_with_entries)
      @user = @manifest.user
      @email = SummaryMailer.summary(@manifest).deliver
    end

    it "should make a basic text version with links to deliver each message" do
      str = @email.text_part.to_s
      @manifest.messages.each do |msg|
        str.should match(/messages\/#{msg.id}\/deliver/)
      end
    end

    it "should make an html version with a form to deliver each message" do
      str = @email.html_part.to_s
      #@manifest.messages.each do |msg|
        #str.should match(/messages\/#{msg.id}\/deliver/)
      #end
    end
  end
end
