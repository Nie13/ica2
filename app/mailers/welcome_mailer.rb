class WelcomeMailer < MailerBase

  def notify(account)
    @account = account
    mail to: to_email(account.email), subject: "Welcome to CitySpade - Spot your next move" do |format|
      format.html
    end
  end
end
