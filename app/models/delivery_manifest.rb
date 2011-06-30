class DeliveryManifest < ActiveRecord::Base
  include DeliverySecret
  belongs_to :user
  has_many :manifest_entries
  has_many :messages, :through => :manifest_entries
  accepts_nested_attributes_for :manifest_entries
  
  def self.summary_for(user)
    messages = user.messages.unsummarized
    self.new(:user => user, :messages => messages)
  end

  def date_range
    start = self.messages.order("created_at ASC").first
    if start.present? 
      start = start.created_at.to_date
    else
      start = self.user.created_at.to_date
    end
    Range.new(start,Time.now.to_date)
  end
  
  def mark_as_delivered!
    messages.each do |m|
      m.update_attribute(:summarized, true)
    end
  end
end
