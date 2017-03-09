class MailPreview < ActionMailer::Preview

  # To preview emails go to: http://localhost:3000/rails/mailers

  def welcome_email
    WelcomeMailer.notify(Account.find(100))
  end

  def recommendation_email
    RecommendMailer.notify(Account.find(3292), :dummy_listings)
  end

  def list_with_us_email
    ListWithUsMailer.notify(ListWithUs.find(20))
  end

  def contact_email
    ContactMailer.notify(Contact.find(20))
  end
  def owner_email
    OwnerMailer.notify(Owner.first)
  end
  def search_me_email
    RoomContactMailer.search_for_me_email(SearchForMe.last)
  end
  def book_showing_email
    RoomContactMailer.book_showing_email(BookShowing.last, Listing.last(5))
  end

  def dealmoon_reply
    RoomContactMailer.dealmoon_reply("Vineeth")
  end
end
