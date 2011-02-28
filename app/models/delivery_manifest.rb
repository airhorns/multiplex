class DeliveryManifest < ActiveRecord::Base
  include DeliverySecret
  belongs_to :user
  has_many :manifest_entries
  has_many :messages, :through => :manifest_entries
  accepts_nested_attributes_for :manifest_entries
end
