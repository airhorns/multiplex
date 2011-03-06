class QueueSummariesJob
  @queue = :queuing

  def self.perform(type)
    User.where(:summary_frequency => type.to_sym).find_each do |user|
      Resque.enqueue(MailSummaryJob, user.id)
    end
  end
end

