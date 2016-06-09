require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    context 'ユーザがトップページにアクセスした時' do
      context '現在時刻より前の開催時間のイベントがある時' do
        it 'そのイベントが表示されていないこと'
      end

      context '現在時刻より後の開催時間のイベントがある時' do
        it 'そのイベントが一覧で表示されていること'
        it '複数ある場合、そのイベントが開催時間が近い順でソートされていること'
      end
    end
  end
end
