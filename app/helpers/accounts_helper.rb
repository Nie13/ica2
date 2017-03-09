module AccountsHelper
  def render_wishlist_link
    if action_name == 'saved_wishlist'
      link_to('Rental', account_saved_wishlist_path(Settings.listing_flags.rental), class: "btn-wishlist #{params[:flag].starts_with?('rent') ? 'current-active': ''}") +
        link_to('Sale', account_saved_wishlist_path(Settings.listing_flags.sale), class: "btn-wishlist #{params[:flag].starts_with?('sale') ? 'current-active' : ''}")
    else
      link_to('Rental', account_past_wishlist_path(Settings.listing_flags.rental), class: "btn-wishlist #{params[:flag].starts_with?('rent') ? 'current-active': ''}") +
        link_to('Sale', account_past_wishlist_path(Settings.listing_flags.sale), class: "btn-wishlist #{params[:flag].starts_with?('sale') ? 'current-active' : ''}")
    end
  end

  def posted_time_for listing
    dh = (Time.now - listing.updated_at).to_i / 3600
    if dh < 1
      'just now'
    elsif dh < 24
      "#{pluralize(dh, 'hour')} ago"
    else
      "#{pluralize(dh / 24, 'day')} ago"
    end
  end

  def render_actived_and_expired_link
    if action_name == "listings"
      link_to('Active Listings', account_listings_path(Settings.listing_status.actived), class: "btn-wishlist #{params[:status].starts_with?('actived') ? 'current-active' : ''}") +
      link_to('Expired Listings', account_listings_path(Settings.listing_status.expired), class: "btn-wishlist #{params[:status].starts_with?('expired') ? 'current-active' : '' }")
    else
      link_to('Active Listings', account_listings_path(Settings.listing_status.actived), class: "btn-wishlist #{params[:status].starts_with?('actived') ? 'current-active' : ''}") +
      link_to('Expired Listings', account_listings_path(Settings.listing_status.expired), class: "btn-wishlist #{params[:status].starts_with?('expired') ? 'current-active' : ''}")
    end
  end
end
