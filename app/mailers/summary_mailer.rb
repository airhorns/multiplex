class SummaryMailer < ActionMailer::Base
  default :from => "Otherbox Summaries <summaries@#{Multiplex::Application::Domain}>"

  def summary(manifest)
    @manifest = manifest
    @user = manifest.user
    start = @user.messages.delivered.first
    if start.present? 
      start = start.created_at.to_date
    else
      start = @user.created_at.to_date
    end
    @date_range = Range.new(start,Time.now.to_date)

    mail(:to => @user.email, :subject => "Otherbox Summary for #{@date_range.begin} to #{@date_range.end} (#{Time.now.to_s})") do |format|
      format.text
      format.html {render :layout => 'email'}
    end
  end
end
