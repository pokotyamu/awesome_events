require 'rails_helper'

describe "events/new", type: :view do
  context 'ログインしているユーザがアクセスした時' do
    before do
      assign(:event, create(:event))
      render
    end

    it '"イベント作成"という見出しのページがrender されていること' do
      expect(rendered).to match(/イベント作成/)
    end

    context 'かつ入力内容に間違いがあった時' do
      it '間違っている内容が表示されていること'
      it 'DB に保存されていないこと'
    end
  end
end
