require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    let(:pre_event) { create_list(:fin_event, 5) }
    let(:next_event) { create_list(:rand_event, 5) }

    context 'イベントが複数ある状態で、ユーザがトップページにアクセスした時' do
      before do
        pre_event
        next_event
        get :index
      end

      it '現在時刻より前のイベントが表示されていないこと' do
        expect(assigns(:events)).not_to match_array(pre_event)
      end

      it 'そのイベントが一覧で表示されていること' do
        expect(assigns(:events)).to match_array(next_event)
      end

      it '複数ある場合、そのイベントが開催時間が近い順でソートされていること' do
        expect(assigns(:events)).to match (next_event.sort_by{ |event| event.start_time })
      end
    end
  end
end
