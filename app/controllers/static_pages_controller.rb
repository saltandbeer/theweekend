class StaticPagesController < ApplicationController

  def home
    if signed_in?
      weeks = Week.all
      @week_items = Hash.new
      weeks.each do |week|
        weekends = Weekend.from_users_followed_by(current_user)
        feed_weekends = weekends.from_week(week)
        @week_items[week] = feed_weekends
      end
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
