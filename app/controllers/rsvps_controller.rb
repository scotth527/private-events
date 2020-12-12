class RsvpsController < ApplicationController
    before_action :authenticate_user!

    def create
        @event = Event.find(params[:event_id])
        @rsvp = Rsvp.new(event_id: @event.id, user_id: params[:user_id], status: params[:status] )
        if @rsvp.save
            flash[:notice] = "Success"
            redirect_to @event
        else
            p "Errors"
            p @rsvp.errors.full_messages
            p "Params"
            p params
            flash[:alert] = 'Something went wrong. Try again later.'
            redirect_to event_path(@event)
        end

    end

    def update
        @event = Event.find(params[:event_id])
        @rsvp = Rsvp.find_by_id(params[:rsvp_id])
        if @rsvp.update(status: params[:status])
            flash[:notice] = "Success"
            redirect_to @event
        else
            flash[:alert] = 'Something went wrong. Try again later.'
            redirect_to event_path(@event)
        end
    end

    def destroy

        # p "Destroy Params"
        # p params
        @rsvp = Rsvp.find(params[:id])
        # p "Rsvp"
        # p @rsvp
        if @rsvp.destroy
          p "This was successful"
          flash[:notice] = "The invitation is removed."
        else
          flash[:alert] = "Something went wrong. Try again later.!"
        end
        redirect_to user_path(current_user)
  end

end
