class UsersController < ApplicationController

    def show
    if (@user = User.find_by_id(params[:id])).present?
      @user = User.find(params[:id])
    else
      content_not_found
    end
  end
end
