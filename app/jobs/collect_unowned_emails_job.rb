class CollectUnownedEmailsJob < MultiplexJob
  @queue = :internal
  def self.perform(user_id)
    @user = User.find(user_id)
    messages = Message.where(:to_email => @user.email)
    messages.each do |message|
      message.user = @user
      message.save!
    end
  end
end 
