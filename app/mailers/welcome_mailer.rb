class WelcomeMailer < MailerBase

  def notify(account)
    @account = account
    mail to: to_email(account.email), subject: "" do |format|
      format.html
    end
  end
end
