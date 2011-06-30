class Internal::UsersController < InternalController
  def test_summary_email
    user = User.find(2)
    @manifest = DeliveryManifest.new(:user => user, :messages => user.messages)
    @manifest.save!
    mail = SummaryMailer.summary(@manifest)
    render :text => mail.html_part.body
    true
  end
end
