class RsvpsController < ApplicationController
    before_action :authenticate_user!

    def create
        @event = Event.find(params[:event_id])
        @rsvp = Rsvp.new(event_id: @event.id, user_id: params[:user_id], status: params[:status] )
        if @rsvp.save
            flash[:notice] = "Success"
            @rsvp.status = "Attending"
            redirect_to @event
        else
            flash[:alert] = 'Something went wrong. Try again later.'
            redirect_to event_path(@event)
        end
    end

    def update

    end

    def destroy
        event = Event.find(params[:event_id])
        rsvp = Rsvp.find(params[:id])
        if current_user == event.creator
          enrollment.destroy
          flash[:notice] = "The invitation is cancelled!"
        else
          enrollment.status = 'invited'
          enrollment.save
          flash[:notice] = "You have dropped the enrollment for the #{event.name}!"
        end

  end

end
