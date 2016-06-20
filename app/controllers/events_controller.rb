class EventsController < ApplicationController
  before_action :authenticate, except: :show

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: '作成しました'
    else
      render :new
    end
  end

  def show
    begin
      @event = Event.find(params[:id])
    rescue
      redirect_to root_path, notice: 'そのイベントは存在しません'
    end
  end

  def edit
    begin
      @event = current_user.created_events.find(params[:id])
    rescue
      redirect_to root_path, notice: 'そのイベントは存在しません'
    end
  end

  def update
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: '更新しました'
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :content, :start_time, :end_time)
  end
end
