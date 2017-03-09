class ContactMailer < MailerBase
  # default from: Settings.email.contact
  default to: [Settings.email.contact, 'kiran.chen@cityspade.com'],
    bcc: Settings.email.bcc

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.notify.subject
  #
  def notify(contact)
    @contact = contact
    mail reply_to: contact.email, subject: contact.subject
  end

  def send_message_to_agent(contact)
    @agent = contact['type'].camelize.constantize.find contact['agent_id']
    @contact = contact
    mail to: to_email(@agent.email),
      reply_to: contact['from_email'],
      subject: 'Someone is interested in your listing!'
  end

  def verify_office_account(account)
    @account = account
    mail to: to_email(account.email), subject: "Verify Account" do |format|
      format.text
    end
  end

  def send_flash_email(contact)
    @contact = contact
    mail from: Settings.email.noreply, to: contact['agent'], bcc: "harry.zhang@cityspade.com", subject: "Someone is interested in the deal"
  end
end
