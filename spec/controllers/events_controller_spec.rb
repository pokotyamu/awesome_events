require 'rails_helper'

describe EventsController, type: :controller do
  describe 'GET #new' do
    context 'ログインユーザがアクセスした時' do
      before do
        set_up_loggin(create(:user), true)
        get :new
      end

      it '@event に、新規Event オブジェクトが格納されていること' do
        expect(assigns(:event)).to be_a_new(Event)
      end
    end
  end

  describe 'POST #create' do
    context 'ログインユーザがアクセスした時' do
      let(:user) { create(:user) }
      let(:last_event) { Event.last }

      before do
        set_up_loggin(user, true)
      end

      context 'かつ正しいパラメータが入っている時' do
        let(:event_params) do
          {
            event:{
              name: "キックオフミーティング",
              place: "カフェスペース",
              content: "大事な会議",
              start_time: DateTime.new(2016,6,3,13,00),
              end_time: DateTime.new(2016,6,3,18,00)
            }
          }
        end

        before { post :create , event_params }

        it 'イベントを新規作成できていること' do
          expect(assigns(:event)).to eq last_event
        end

        it '各パラメータが正しく格納されていること' do
          expect(assigns(:event).owner_id).to eq last_event.owner_id
          expect(assigns(:event).place).to eq last_event.place
          expect(assigns(:event).content).to eq last_event.content
          expect(assigns(:event).start_time).to eq last_event.start_time
          expect(assigns(:event).end_time).to eq last_event.end_time
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ユーザがアクセスした時' do
      let(:event) { create(:future_event) }

      before do
        get :show, id: event.id
      end
      context 'かつ、作成しているイベントのページの時' do
        it '@event に、パラメータで指定したid のイベントが格納されている'  do
          expect(assigns(:event).owner_id).to eq  event.owner_id
          expect(assigns(:event).place).to eq event.place
          expect(assigns(:event).content).to eq event.content
          expect(assigns(:event).start_time).to eq event.start_time
          expect(assigns(:event).end_time).to eq event.end_time
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインユーザが主催者のイベント編集ページで更新ボタンが押された時' do
      let!(:user) { create(:user) }
      let!(:event) { create(:future_event, owner_id: user.id) }

      before do
        set_up_loggin(user, true)
      end

      context 'かつ正しいパラメータが入っている時' do
        let(:params) do
          {
            id: event.id,
            owner_id: event.owner_id,
            name: "update event name",
            place: "update event place",
            content: "update event context",
            start_time: DateTime.new(event.start_time.year,1,1,00,00),
            end_time: DateTime.new(event.end_time.year,1,1,01,00)
          }
        end

        before do
          patch :update, {id: event.id, event: params}
        end

        it '各パラメータが正しく格納されていること' do
          updated_event = Event.find(event.id)
          expect(updated_event.id).to eq params[:id]
          expect(updated_event.owner_id).to eq params[:owner_id]
          expect(updated_event.name).to eq params[:name]
          expect(updated_event.place).to eq params[:place]
          expect(updated_event.start_time).to eq params[:start_time]
          expect(updated_event.end_time).to eq params[:end_time]
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインユーザとイベントの主催者が違う時' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:event) { create(:future_event, owner_id: other_user.id) }

      before do
        set_up_loggin(user, true)
        delete :destroy, id: event.id
      end

      it 'イベントが削除されていないこと' do
        expect(Event.find(event.id)).to eq event
        expect(Event.count).to eq 1
      end
    end

    context 'ログインユーザとイベントの主催者が同じ時' do
      let(:user) { create(:user) }
      let(:event) { create(:future_event, owner_id: user.id) }

      before do
        set_up_loggin(user, true)
        delete :destroy, id: event.id
      end

      it 'イベントが削除されていること' do
        expect { Event.find(event.id) }.to raise_error ActiveRecord::RecordNotFound
        expect(Event.count).to eq 0
      end
    end
  end
end
