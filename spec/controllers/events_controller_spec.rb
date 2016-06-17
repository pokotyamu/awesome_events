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
      context 'かつ、作成しているイベントのページの時' do
        it 'ステータスコードとして200が返ること' do
          expect(response.status).to eq(200)
        end

        it '@event に、パラメータで指定したid のイベントが格納されている'  do
          expect(assigns(:event).owner_id).to eq  event.owner_id
          expect(assigns(:event).place).to eq event.place
          expect(assigns(:event).content).to eq event.content
          expect(assigns(:event).start_time).to eq event.start_time
          expect(assigns(:event).end_time).to eq event.end_time
        end

        it 'show テンプレートをrender していること' do
          expect(response).to render_template :show
        end
      end

      context 'かつ、作成していないイベントのページの時' do
        before do
          get :show, id: 0
        end

        it 'トップページにリダイレクトすること' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user)}
    let(:user_event) { create(:future_event, owner_id: user.id) }

    context 'ログインユーザが主催者でないイベント編集ページにアクセスした時' do
      let(:other_user) { create(:user)}

      before do
        session[:user_id] = other_user.id
        get :edit, id: 1
      end

      it 'トップページにリダイレクトすること' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインユーザが主催者のイベント編集ページにアクセスした時' do
      before do
        session[:user_id] = user.id
        get :edit, id: user_event.id
      end

      it '@event のedit テンプレートをrender していること' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:event) { create(:future_event) }

    before do
      session[:user_id] = user.id
    end

    context 'ログインユーザが主催者のイベント編集ページで更新ボタンが押された時' do
      context 'かつ、パラメータに不備がある時' do
        let(:params) do
          {
              name: "大事な会議",
              start_time: DateTime.new(event.start_time.year,6,3,13,00),
              end_time: DateTime.new(event.start_time.year - 1,6,3,12,00) #=> 1年前に変更。
          }
        end

        before do
          patch :update, {id: event.id, event: params}
        end

        it '@event のedit テンプレートをrender していること' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'かつ正しいパラメータが入っている時' do
      let(:params) do
        {
          event:{
            id: event.id,
            owner_id: event.owner_id,
            name: "update event name",
            place: "update event place",
            context: "update event context",
            start_time: DateTime.new(event.start_time.year,1,1,00,00),
            end_time: DateTime.new(event.end_time.year,1,1,01,00)
          }
        }
      end

      before do
        patch :update, {id: event.id, event: params}
      end

      it '各パラメータが正しく格納されていること' do
        updated_event = Event.find(event.id)
        expect(updated_event.id).to eq params[:event][:id]
        expect(updated_event.owner_id).to eq params[:event][:owner_id]
        expect(updated_event.name).to eq params[:event][:name]
        expect(updated_event.place).to eq params[:event][:place]
        expect(updated_event.start_time).to eq params[:event][:start_time]
        expect(updated_event.end_time).to eq params[:event][:end_time]
      end

      it 'show テンプレートをrender していること' do
        expect(response).to render_template :show
      end
    end
  end
end
