require 'spec_helper'

describe UsersController do
  describe "unsubscribing" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "should unsubscribe a user given the correct secret" do
      User.should_receive(:find).with(@user.id).and_return(@user)
      @user.should_receive(:unsubscribe).and_return(true)
      get :unsubscribe, {:id => @user.id, :secret => @user.delivery_secret}
    end

    it "shouldn't unsubscribe a user if the wrong secret is given" do
      User.should_receive(:find).with(@user.id).and_return(@user)
      @user.should_not_receive(:unsubscribe)
      get :unsubscribe, {:id => @user.id, :secret => @user.delivery_secret[0..10]}
    end
  end
end
