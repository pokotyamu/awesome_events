require 'rails_helper'

RSpec.describe "events/new", type: :view do
  context 'ログインしているユーザがアクセスした時' do
    before do
      assign(:event, create(:event))
      render
    end

    it '"イベント作成"という見出しのページがrender されていること' do
      expect(rendered).to match(/イベント作成/)
    end
  end
end
