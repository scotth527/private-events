class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id]
    if @user.present?
        return @user 
    else
        content_not_found
    end
  end
end
