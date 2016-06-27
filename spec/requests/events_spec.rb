require 'rails_helper'

def setup(user,logged_in)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(logged_in)
end

RSpec.describe "Events", type: :request do
  describe 'GET /events/:id' do
    context '存在するイベントにアクセスした時' do
      subject { get "/events/#{event.id}"}

      let(:event) { create(:future_event) }
      let(:template) { 'show' }

      it_behaves_like 'HTTP 200 OK'
      it_behaves_like 'render template'
    end

    context '存在しないイベントにアクセスした時' do
      subject { get "/events/100"}

      let(:redirect_path) { root_path }

      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end
  end

  describe 'POST /events' do
    subject { post '/events' , params }

    context '未ログインユーザがアクセスした時' do
      let(:redirect_path) { root_path }
      let(:params) {}
      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end

    context 'ログインユーザがアクセスした時' do
      let(:user) { create(:user) }

      before do
        setup(user,true)
      end

      context 'かつ、入力パラメータが不適な時' do
        let(:template) { 'new' }
        let(:params) do
          {
            event:{
              content: '大事な会議',
              start_time: DateTime.new(2016,6,3,13,00),
              end_time: DateTime.new(2015,6,3,18,00)
            }
          }
        end
        it_behaves_like 'HTTP 200 OK'
        it_behaves_like 'render template'
      end

      context 'かつ、入力パラメータが適切な時' do
        let(:template) { 'show' }
        let(:params) do
          {
            event:{
              name: 'sample name',
              place: 'sample place',
              owner_id: user.id,
              content: 'sample content',
              start_time: DateTime.new(2016,6,3,13,00),
              end_time: DateTime.new(2016,6,3,18,00)
            }
          }
        end
        let(:redirect_path) { event_path(assigns(:event)) }

        it_behaves_like 'HTTP 302 OK'
        it_behaves_like 'redirect'
      end
    end
  end

  describe 'GET /events/new' do
    subject { get '/events/new' }

    context '未ログインユーザがアクセスした時' do
      let(:redirect_path) { root_path }
      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end

    context 'ログインユーザがアクセスした時' do
      let(:user) { create(:user) }
      let(:template) { 'new' }

      before do
        setup(user,true)
      end

      it_behaves_like 'HTTP 200 OK'
      it_behaves_like 'render template'
    end
  end

  describe 'GET /events/:id/edit' do
    subject { get "/events/#{user_event.id}/edit" }

    let(:user) { create(:user) }
    let(:user_event) { create(:future_event, owner_id: user.id) }

    context 'ログインユーザが主催者でないイベント編集ページにアクセスした時' do
      let(:other_user) { create(:user) }
      let(:redirect_path) { root_path }

      before do
        setup(other_user,true)
      end

      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end

    context 'ログインユーザが主催者のイベント編集ページにアクセスした時' do
      let(:user) { create(:user)}
      let(:user_event) { create(:future_event, owner_id: user.id) }
      let(:template) { 'edit' }

      before do
        setup(user,true)
      end

      it_behaves_like 'HTTP 200 OK'
      it_behaves_like 'render template'
    end
  end

  describe 'PATCH /events/:id' do
    context 'ログインユーザが主催者のイベント編集ページにアクセスした時' do
      subject { patch "/events/#{user_event.id}", params }

      let(:user) { create(:user) }
      let(:user_event) { create(:future_event, owner_id: user.id) }

      before do
        setup(user,true)
      end

      context 'かつ、入力パラメータが不適な時' do
        let(:template) { 'edit' }
        let(:params) do
          {
            event:{
              name: 'sample name',
              place: 'sample place',
              content: 'sample content',
              start_time: DateTime.new(2016,6,3,13,00),
              end_time: DateTime.new(2015,6,3,18,00)
            }
          }
        end

        it_behaves_like 'HTTP 200 OK'
        it_behaves_like 'render template'
      end

      context 'かつ、入力パラメータが適切な時' do
        let(:template) { 'show' }
        let(:params) do
          {
            event:{
              name: 'sample name',
              place: 'sample place',
              owner_id: user.id,
              content: 'sample content',
              start_time: DateTime.new(2016,6,3,13,00),
              end_time: DateTime.new(2016,6,3,18,00)
            }
          }
        end
        let(:redirect_path) { event_path(assigns(:event)) }

        it_behaves_like 'HTTP 302 OK'
        it_behaves_like 'redirect'
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete "/events/#{user_event.id}" }

    let(:user) { create(:user) }
    let(:user_event) { create(:future_event, owner_id: user.id) }

    context 'ログインユーザとイベントの主催者が違う時' do
      let(:other_user) { create(:user) }
      let(:redirect_path) { root_path }

      before do
        setup(other_user,true)
      end

      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end

    context 'ログインユーザとイベントの主催者が同じ時' do
      let(:redirect_path) { root_path }

      before do
        setup(user,true)
      end

      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end
  end
end
