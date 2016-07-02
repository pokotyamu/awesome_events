class TicketsController < ApplicationController
  def create
    ticket = current_user.tickets.build do |t|
      t.event_id = params[:event_id]
      t.comment = comment_params[:comment]
    end
    ticket.save
    flash[:notice] = 'このイベントに参加表明しました'
    head 201
  end

  private

  def comment_params
    params.require(:ticket).permit(:comment)
  end
end
