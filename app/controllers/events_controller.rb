class EventsController < ApplicationController
  before_action :authenticate

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    render :new unless @event.save
    head :ok
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :content, :start_time, :end_time)
  end
end
