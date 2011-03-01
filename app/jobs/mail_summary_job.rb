class MailSummaryJob < MultiplexJob
  @queue = :outgoing

  def self.perform(user_id)
    @user = User.find(user_id)
    if @user.messages.undelivered.count > 0
      manifest = DeliveryManifest.new(:messages => @user.messages.undelivered, :user => @user)
      manifest.save!
      mail = SummaryMailer.summary(manifest)
      mail.deliver!
    end
  end
end
