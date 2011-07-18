class QueueSummariesJob < MultiplexJob
  @queue = :queuing

  def self.perform(type)
    User.enabled.where(:summary_frequency => type.to_sym).find_each do |user|
      Resque.enqueue(MailSummaryJob, user.id)
    end
  end
end
