class SummaryMailer < ActionMailer::Base
  default :from => "Othermail Summaries <summaries@#{Multiplex::Application::Domain}>"
  layout 'email'

  def summary(manifest)
    @manifest = manifest
    @user = manifest.user
    @date_range = manifest.date_range

    mail(:to => @user.email, :subject => "Othermail Summary for #{@date_range.begin} to #{@date_range.end} (#{Time.now.to_s})", 'List-Help' => "<mailto:help@othermail.me>", 'List-Unsubscribe' => "<mailto:unsubscribe@othermail.me>", "List-Id" => "<#{@user.mask_email_name}.summaries.othermail.me>") do |format|
      format.text
      format.html 
    end
  end

  def help(user)
    @user = user
    mail(:to => @user.email, :subject => "Othermail Help") do |f|
      f.text
      f.html
    end
  end
end
