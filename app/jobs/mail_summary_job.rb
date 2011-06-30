class MailSummaryJob < MultiplexJob
  @queue = :outgoing

  def self.perform(user_id)
    user = User.find(user_id)
    manifest = DeliveryManifest.summary_for(user)
    
    if manifest.messages.to_a.count > 0
      manifest.save!
      mail = SummaryMailer.summary(manifest)
      mail.deliver!
      manifest.mark_as_delivered!
      true
    end
  end
end
