class EventsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :delete]
 

  def show
    @events = Event.all.order("created_at DESC")

    if (@event = Event.find_by_id(params[:id])).present?
      @event = Event.find(params[:id])
    else
      content_not_found
    end
  end

  def new
    @event = current_user.events.build
  end

  def index
    @events = Event.all.select { |event| event.date.present? }

  end

  def create
    @event = current_user.events.build(post_params)
    @events = Event.all

    respond_to do |format|
       if @event.save
         format.html { redirect_to root_path, notice: 'Event was successfully created.' }
         format.json { render :show, status: :created, location: @event }
       else
         format.html { render :index }
         format.json { render json: @event.errors, status: :unprocessable_entity }
       end

    end
 end


 private

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:event).permit(:title, :description, :location,:date , :user_id)
    end
end
