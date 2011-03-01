class MailMessageJob < MultiplexJob
  @queue = :outgoing

  def self.perform(message_id)
    @message = Message.find(message_id)
    unless @message.delivered
      @message.deliver!
    end
  end
end

