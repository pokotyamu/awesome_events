require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  describe "POST /events/:event_id/tickets" do
    subject { post "/events/#{event.id}/tickets", ticket_params }

    let(:event) { create(:future_event) }

    before { login(create(:user)) }
    context '値が正しい時' do
      let(:ticket_params) do
        {
          ticket: {
            comment: 'test comment'
          }
        }
      end

      it 'チケットが１つ作成されること' do
        expect{ subject }.to change(Ticket, :count).by(1)
      end
    end
  end
end
