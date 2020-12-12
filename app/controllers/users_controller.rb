class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :only_see_own_page, only: [:show]

    def show
        if (@user = User.find_by_id(params[:id])).present?
          @user = User.find(params[:id])

          @past_events = @user.attended_events.past_events(Date.today).order('date DESC')
          @upcoming_events = @user.attended_events.upcoming_events(Date.today).sort_by &:date
          p "Upcoming events"
          p @upcoming_events
        else
          content_not_found
        end
    end


    private
    def only_see_own_page
      @user = User.find(params[:id])

      if current_user != @user
        redirect_to root_path, notice: "Sorry, but you are only allowed to view your own profile page."
      end
    end
end
