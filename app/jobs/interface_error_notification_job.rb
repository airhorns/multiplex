class InterfaceErrorNotificationJob < MultiplexJob
  @queue = :outgoing

  def self.perform(type, from)
    InterfaceErrorMailer.error(type, from).deliver!
  end
end


