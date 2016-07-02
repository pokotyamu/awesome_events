require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  describe "GET /events/:event_id/tickets/new" do
    subject { get "/events/#{:event_id}/tickets/new" }

    let(:event) { create(:future_event) }

    before { login(create(:user)) }

    context 'url を直接アクセスした時' do
      let(:redirect_path) { root_path }
      it_behaves_like 'HTTP 302 Found'
      it_behaves_like 'redirect'
      it_behaves_like 'flash' do
        let(:message) { '正しい手順でイベントに参加してください' }
      end
    end
  end

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

      it_behaves_like 'HTTP 201 Created'
      it_behaves_like 'flash' do
        let(:message) { 'このイベントに参加表明しました' }
      end
    end

    context '値が間違っている時' do
      let(:ticket_params) do
        {
          ticket: {
            comment: 'a' * 31
          }
        }
      end

      it_behaves_like 'HTTP 422 Unprocessable Entity'
    end
  end
end
