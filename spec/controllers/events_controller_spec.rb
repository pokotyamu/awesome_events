require 'rails_helper'

describe EventsController do
  describe 'GET #new' do
    context '未ログインユーザがアクセスした時' do
      before { get :new }

      it 'トップページにリダイレクトすること' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインユーザがアクセスした時' do
      before do
        user = create(:user)
        session[:user_id] = user.id
        get :new
      end

      it 'ステータスコードとして200が返ること' do
        expect(response.status).to eq(200)
      end

      it '@event に、新規Event オブジェクトが格納されていること' do
        expect(assigns(:event)).to be_a_new(Event)
      end

      it 'new テンプレートをrender していること' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    context '未ログインユーザがアクセスした時' do
      before { post :create }

      it 'トップページにリダイレクトすること' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインユーザがアクセスした時' do
      let(:user) { create(:user) }
      let(:last_event) { Event.last }
      before do
        session[:user_id] = user.id
      end

      context 'かつパラメータ不足している時' do
        let(:error_event_params) do
          {
            event:{
              content: "大事な会議",
              start_time: DateTime.new(2016,6,3,13,00),
              end_time: DateTime.new(2016,6,3,18,00)
            }
          }
        end

        before { post :create , error_event_params }

        it 'new テンプレートをrender していること' do
          expect(response).to render_template :new
        end
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

        it 'show テンプレートをrender していること' do
          expect(response).to redirect_to(event_path(assigns(:event)))
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

      it 'ステータスコードとして200が返ること' do
        expect(response.status).to eq(200)
      end

      it '@event に、パラメータで指定したid のイベントが格納されている'  do
        expect(assigns(:event).owner_id).to eq  event.owner_id
        expect(assigns(:event).place).to eq event.place
        expect(assigns(:event).content).to eq event.content
        expect(assigns(:event).start_time.to_s).to eq event.start_time.to_s
        expect(assigns(:event).end_time.to_s).to eq event.end_time.to_s
      end

      it 'show テンプレートをrender していること' do
        expect(response).to render_template :show
      end
    end
  end
end
