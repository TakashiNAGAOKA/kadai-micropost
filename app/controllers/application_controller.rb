class ApplicationController < ActionController::Base
  include SessionsHelper  #追記
  include Pagy::Backend

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.favorings.count
  end

#  def mp_counts(micropost)
#    @count_favorings = micropost.favorings.count
#  end

end
