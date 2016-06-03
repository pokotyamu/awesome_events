require 'rails_helper'

describe "events/new", type: :view do
  context 'ログインしているユーザがアクセスした時' do
    it '"イベント作成"という見出しのページがrender されていること' do
      render
      expect(rendered).to match(/イベント作成/)
    end

    context 'かつ入力内容に間違いがあった時' do
      it '間違っている内容が表示されていること'
      it 'DB に保存されていないこと'
    end
  end
end
