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
      @tickets = @event.tickets.includes(:user).order(:created_at)
    rescue
      redirect_to root_path, alert: 'そのイベントは存在しません'
    end
  end

  def edit
    begin
      @event = current_user.created_events.find(params[:id])
    rescue
      redirect_to root_path, alert: 'そのイベントは存在しません'
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

  def destroy
    begin
      @event = current_user.created_events.find(params[:id])
      @event.destroy!
      redirect_to root_path, notice: '削除しました'
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path, alert: '主催者でないイベントは削除できません'
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :content, :start_time, :end_time)
  end
end
