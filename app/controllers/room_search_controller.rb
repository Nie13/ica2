class RoomSearchController < ApplicationController
  def index
    collection = Room.active
    Roommate.active.each{|r| collection << r}
    all_posts = collection.sort_by(&:created_at).reverse
    posts = Kaminari.paginate_array(all_posts).page(params[:page]).per(24)

    link_hash = {
      "QH服务列表" => roommates_path,
      "LT服务列表" => rooms_path
    }

    render "room_search/_index_layout",
      locals:{
        total_post_count: all_posts.count,
        posts: posts,
        heading: "获取所有的服务列表",
        new_path: new_room_path,
        link_hash: link_hash
      }
  end
end
