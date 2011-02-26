require 'spec_helper'

describe "messages/index.html.haml" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :to_name => "To Name",
        :to_email => "To Email",
        :user_id => 1,
        :from_name => "From Name",
        :from_email => "From Email",
        :subject => "Subject",
        :html_body => "Html Body",
        :text_body => "Text Body"
      ),
      stub_model(Message,
        :to_name => "To Name",
        :to_email => "To Email",
        :user_id => 1,
        :from_name => "From Name",
        :from_email => "From Email",
        :subject => "Subject",
        :html_body => "Html Body",
        :text_body => "Text Body"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "To Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "To Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "From Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "From Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Html Body".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Text Body".to_s, :count => 2
  end
end
