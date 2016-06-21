require 'rails_helper'

RSpec.feature "DestroyEvents", type: :feature do
  describe 'ユーザがイベントの削除を行う時' do
    context 'かつ、イベント一覧ページから行う時' do
      context 'かつ、削除確認で「ok」を押した時' do
        it 'イベント一覧ページが表示されていること'
        it '"削除しました"と表示されてること'
      end

      context 'かつ、削除確認で「キャンセル」を押した時' do
        it 'イベント一覧ページが表示されていること'
      end
    end
    context 'かつ、イベント詳細ページから行う時' do
      context 'かつ、削除確認で「ok」を押した時' do
        it 'イベント一覧ページが表示されていること'
        it '"削除しました"と表示されてること'
      end

      context 'かつ、削除確認で「キャンセル」を押した時' do
        it 'そのイベントの詳細ページが表示されていること'
      end
    end
  end
end
