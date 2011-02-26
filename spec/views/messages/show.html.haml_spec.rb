require 'spec_helper'

describe "messages/show.html.haml" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :to_name => "To Name",
      :to_email => "To Email",
      :user_id => 1,
      :from_name => "From Name",
      :from_email => "From Email",
      :subject => "Subject",
      :html_body => "Html Body",
      :text_body => "Text Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/To Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/To Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/From Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/From Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Html Body/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Text Body/)
  end
end
