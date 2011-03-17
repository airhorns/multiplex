require 'mail'

FactoryGirl.define do
  factory :invite do
    used true
    sequence :code do |n|
      "ABC#{n}"
    end
  end
 
  factory :user do
    association :invite
    sequence :email do |n|
      "harry.brundage+#{n}@gmail.com"
    end
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
    params ""
    delivered false
    summarized false
    sequence :subject do |n|
      "Newsletter #{n}"
    end
    mail { Mail::Message.new(subject:subject, to:"#{to_name} <#{to_email}>", from:"#{from_name} <#{from_email}>", :text => "Hello", :html => "<b>Hello</b>") } 
  end

  factory :manifest_entry do
    association :message
    marked_for_delivery false
  end

  factory :manifest_entry_with_manifest, :parent => :manifest_entry do
    association :delivery_manifest
  end
  
  factory :delivery_manifest do
    association :user
  end

  factory :delivery_manifest_with_entries, :parent => :delivery_manifest do |manifest|
    manifest.after_build do |manifest| 
      3.times do 
        manifest.manifest_entries << FactoryGirl.build(:manifest_entry, :delivery_manifest => manifest)
      end
    end
  end
end
