module DeliverySecret
  @@generator = UUID.new

  def self.included(base) 
    base.before_create :set_delivery_secret
    #base.validates_presence_of :delivery_secret
  end
  private
  def set_delivery_secret
    self.delivery_secret = Digest::SHA1.hexdigest @@generator.generate
  end
end
