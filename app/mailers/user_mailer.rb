class UserMailer < ::Devise::Mailer
  layout 'email'
  
  def invite(email, invite = nil)
    @invite = invite || Invite.create!
    mail(:to => email, :subject => "Othermail Invite", :from => "Othermail Invites <support@othermail.me>") 
  end
end
