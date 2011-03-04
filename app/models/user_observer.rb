class UserObserver < ActiveRecord::Observer
    # Check for unowned emails
  def after_create(user)
    Resque.enqueue(CollectUnownedEmailsJob, user.id)
  end
end
