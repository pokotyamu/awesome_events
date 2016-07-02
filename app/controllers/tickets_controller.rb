class TicketsController < ApplicationController
  before_action :authenticate

  def new
    flash[:notice] = '正しい手順でイベントに参加してください'
    redirect_to root_path
  end

  def create
    ticket = current_user.tickets.build do |t|
      t.event_id = params[:event_id]
      t.comment = comment_params[:comment]
    end
    if ticket.save
      flash[:notice] = 'このイベントに参加表明しました'
      head 201
    else
      render json: { messages: ticket.errors.full_messages }, status: 422
    end
  end

  private

  def comment_params
    params.require(:ticket).permit(:comment)
  end
end
