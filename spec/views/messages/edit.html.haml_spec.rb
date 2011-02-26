require 'spec_helper'

describe "messages/edit.html.haml" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :to_name => "MyString",
      :to_email => "MyString",
      :user_id => 1,
      :from_name => "MyString",
      :from_email => "MyString",
      :subject => "MyString",
      :html_body => "MyString",
      :text_body => "MyString"
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path(@message), :method => "post" do
      assert_select "input#message_to_name", :name => "message[to_name]"
      assert_select "input#message_to_email", :name => "message[to_email]"
      assert_select "input#message_user_id", :name => "message[user_id]"
      assert_select "input#message_from_name", :name => "message[from_name]"
      assert_select "input#message_from_email", :name => "message[from_email]"
      assert_select "input#message_subject", :name => "message[subject]"
      assert_select "input#message_html_body", :name => "message[html_body]"
      assert_select "input#message_text_body", :name => "message[text_body]"
    end
  end
end
