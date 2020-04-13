class HomeController < ApplicationController
  before_action :login_required, only: [:timeline]
  def top
  end
  def map
  end
  def timeline
    if current_user
      @feed_items = current_user.feed
    end
  end
end
