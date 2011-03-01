class InterfaceErrorMailer < ActionMailer::Base
  default :from => "OtherBox Errors <support@otherbox.me>"

  def error(path, message)

  end
end
