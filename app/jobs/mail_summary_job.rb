class MailSummaryJob < MultiplexJob
  @queue = :outgoing

  def self.perform(user_id)
    user = User.find(user_id)
    messages = user.messages.unsummarized
    
    if messages.count > 0
      manifest = DeliveryManifest.new(:messages => messages, :user => user)
      manifest.save!
      SummaryMailer.summary(manifest).deliver!
      messages.update_all(:summarized => true)
    end
  end
end
