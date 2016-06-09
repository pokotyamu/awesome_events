require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    describe 'ユーザがトップページにアクセスした時' do
      context 'イベントが単数の時' do
        let(:pre_event) { create(:closed_event) }
        let(:next_event) { create(:rand_event) }

        before do
          pre_event
          next_event
          get :index
        end

        it '開催済みのイベントが表示されていないこと' do
          expect(assigns(:events)).not_to include(pre_event)
        end

        it 'まだ開催されていないイベントが一覧で表示されていること' do
          expect(assigns(:events)).to include(next_event)
        end
      end

      context 'イベントが複数ある時' do
        let(:pre_events) { create_list(:closed_event, 5) }
        let(:next_events) { create_list(:rand_event, 5) }

        before do
          pre_events
          next_events
          get :index
        end

        it '開催済みのイベントが表示されていないこと' do
          expect(assigns(:events)).not_to match_array(pre_events)
        end

        it 'まだ開催されていないイベントが一覧で表示されていること' do
          expect(assigns(:events)).to match_array(next_events)
        end

        it '表示されいてるイベントが開催時間が近い順でソートされていること' do
          expect(assigns(:events)).to match (next_events.sort_by{ |event| event.start_time })
        end
      end
    end
  end
end
