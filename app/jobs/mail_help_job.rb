class MailHelpJob < MultiplexJob
  @queue = :outgoing

  def self.perform(user_id)
    user = User.find(user_id)
    SummaryMailer.help(user).deliver! 
  end
end

