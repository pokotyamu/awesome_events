class EventsController < ApplicationController
  before_action :authenticate

  def new
    @event = current_user.created_events.build
  end

  def create
    head :ok
  end
end
