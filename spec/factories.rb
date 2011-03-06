require 'mail'

FactoryGirl.define do
  factory :user do
    email 'harry.brundage@gmail.com'
    sequence :mask_email do |n| 
      "harry#{n}@#{Multiplex::Application::Domain}" 
    end
    summary_frequency :weekly
    confirmed_at Time.now
  end

  factory :message do
    association :user
    to_email { user.mask_email}
    to_name "Harry"
    from_email "newsletter@google.com"
    from_name "Google Newsletter"
    subject "Newsletter"
    params ""
    mail { Mail::Message.new(subject:subject, to:"#{to_name} <#{to_email}>", from:"#{from_name} <#{from_email}>", :text => "Hello", :html => "<b>Hello</b>") } 
  end
end
