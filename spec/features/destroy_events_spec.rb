require 'rails_helper'

RSpec.feature "DestroyEvents", type: :feature do
  # NOTE: capybara での confirm ダイアログのボタンの押し方が分からなかったため、pending としている
  describe 'ユーザがイベントの削除を行う時' do
    context 'かつ、イベント詳細ページから行う時' do
      context 'かつ、削除確認で「ok」を押した時' do
        pending 'イベント一覧ページが表示されていること'
        pending '"削除しました"と表示されてること'
      end

      context 'かつ、削除確認で「キャンセル」を押した時' do
        pending 'そのイベントの詳細ページが表示されていること'
      end
    end
  end
end
