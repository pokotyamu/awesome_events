require 'rails_helper'

RSpec.feature "NewEvents", type: :feature do
  describe 'ユーザが"イベントを作る"をクリックした時' do

    context 'ログインしていないユーザの時' do
      it '"ログインしてください"というアラートが表示されること'
      it 'トップページに戻ること'
    end

    context 'ログインしているユーザの時' do
      it '新規イベント作成画面に遷移すること'
      context 'かつ、作成ボタンを押した時に、イベントの属性に不備があった時' do
        it '新規イベント作成画面に遷移すること'
        it 'エラーの内容が表示されていること'
      end
      context 'かつ、作成ボタンを押した時に、不備なくイベントの属性が入力されている時' do
        it '作成したイベントの詳細ぺージに遷移していること'
      end
    end
  end
end
