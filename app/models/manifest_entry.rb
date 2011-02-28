class ManifestEntry < ActiveRecord::Base
  belongs_to :delivery_manifest
  belongs_to :message

  after_save :queue_delivery

  def queue_delivery
    message.queue_delivery if self.marked_for_delivery
  end
end
