class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :delete, :destroy]
  before_action :authenticate_user!, only:[:new, :create, :index, :edit, :show, :update, :delete]

  def show
    @events = Event.all.order("created_at DESC")

    if (@event = Event.find_by_id(params[:id])).present?
      @event = Event.find(params[:id])

      @users = User.all.select{ |user| user.username != current_user.username}
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

 def update

     respond_to do |format|
       if @event.update(post_params)
         format.html { redirect_to @event, notice: 'Event was successfully updated.' }
         format.json { render :show, status: :ok, location: @event }
       else
         format.html { render :edit }
         format.json { render json: @event.errors, status: :unprocessable_entity }
       end
     end
 end

 def edit

 end

 def destroy
     p "Destroyed event"
     p @event
     @event.destroy
     respond_to do |format|
       format.html { redirect_to user_url(current_user), notice: 'Event was successfully destroyed.' }
       format.json { head :no_content }
     end
 end

 private

     def set_event
       @event = Event.find(params[:id])
     end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:event).permit(:title, :description, :location,:date , :user_id)
    end
end
