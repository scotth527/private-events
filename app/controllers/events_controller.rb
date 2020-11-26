class EventsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :delete]

  def show
    @events = Event.all.order("created_at DESC")
    puts @events
  end

  def new
    @event = current_user.events.build
  end

  def index
    @events = Event.all
  end

  def create
    @event = current_user.events.build(post_params)
    @events = Event.all
  end

  respond_to do |format|
     if @event.save
       format.html { redirect_to root_path, notice: 'Event was successfully created.' }
       format.json { render :show, status: :created, location: @event }
     else
       format.html { render :index }
       format.json { render json: @event.errors, status: :unprocessable_entity }
     end
 end


 private


    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :location,:date , :user_id)
    end
end