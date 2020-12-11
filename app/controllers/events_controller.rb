class EventsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :delete]


  def show
    @events = Event.all.order("created_at DESC")
    @users = User.all.select{ |user| user.username != current_user.username }
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
    @past_events = Event.past_events(Date.today).order('date DESC')
    @upcoming_events = Event.upcoming_events(Date.today).sort_by &:date
  end

  def create
    @event = current_user.events.build(post_params)
    @events = Event.all

    respond_to do |format|
       if @event.save
         ##By default creator of event is going to event
         @rsvp = Rsvp.new( event_id: @event.id , user_id: current_user.id, status: "Attending")
         @rsvp.save
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
