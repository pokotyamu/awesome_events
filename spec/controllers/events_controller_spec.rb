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
        #ログインしているユーザを作成する処理を書く
        get :new
      end

      it 'ステータスコードとして200が返ること' do
        expect(response).to redirect_to(root_path)
      end

      it '@event に、新規Event オブジェクトが格納されていること'

      it 'new テンプレートをrender していること'

    end
  end
end
