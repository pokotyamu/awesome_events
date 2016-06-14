require 'rails_helper'

RSpec.describe "welcome/index", type: :view do
  context 'ログインユーザがアクセスした時' do
    it 'まだ開催していないイベント一覧が表示されている'

    context 'ログインユーザが作成したイベントが存在するとき' do
      it 'そのイベントに対する「編集」ボタンが表示されている'
    end
  end
end
