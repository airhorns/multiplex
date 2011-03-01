class InterfaceErrorNotificationJob < MultiplexJob
  @queue = :outgoing

  def self.perform(type)
    InterfaceErrorMailer.error(type).deliver!
  end
end


