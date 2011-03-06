class DeliveryManifest < ActiveRecord::Base
  include DeliverySecret
  belongs_to :user
  has_many :manifest_entries
  has_many :messages, :through => :manifest_entries
  accepts_nested_attributes_for :manifest_entries

  def date_range
    start = self.user.messages.summarized.first
    if start.present? 
      start = start.created_at.to_date
    else
      start = self.user.created_at.to_date
    end
    Range.new(start,Time.now.to_date)
  end

end
