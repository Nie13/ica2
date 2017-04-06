class RoomContactMailer < ActionMailer::Base
  default from: Settings.email.noreply
  def contact_email(email, subject, body, description, room)
    @body = body
    @description = description
    address = Mail::Address.new email
    mail  to: room.account.email, cc: address.format, bcc: "vvlll2flri@outlook.com", subject: subject
  end

  def search_for_me_email(form_info)
    @form_info = form_info
    mail  to: "vvlll2flri@outlook.com", cc: "vvlll2flri@outlook.com", bcc: "vvlll2flri@outlook.com", subject: "Search For Me"
  end

  def dealmoon_reply(name, email)
    @name = name
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo/logo2.png")
    attachments.inline['qrcode.png'] = File.read("#{Rails.root}/app/assets/images/mail/city-qrcode.png")
    mail from: "vvlll2flri@outlook.com", to: email, subject: "CitySpade租房咨询回复"
  end

  def book_showing_email(booking, listings, info)
    @booking = booking
    @listings = listings
    @info = info
    mail to: "vvlll2flri@outlook.com", cc: booking.email, bcc:"vvlll2flri@outlook.com", subject: "Booking Confirmation"
  end

  def client_application(info)
    @info = info
    subject = "Application - #{@info[:fname]} #{@info[:lname]} [ #{@info[:building]} #{@info[:unit]} ]"
    mail to: "vvlll2flri@outlook.com", bcc: "vvlll2flri@outlook.com", subject: subject
  end
end
