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

    context 'かつ入力内容に間違い(不備)があった時' do
      let(:error_event) { build(:event, name: "") }
      before do
        error_event.valid?
        assign(:event, error_event)
        render
      end

      it '間違っている内容が表示されていること' do
        expect(rendered).to match /#{error_event.errors.full_messages.first}/
      end

      it 'DB に保存されていないこと' do
        expect(Event.last).not_to eq error_event
      end
    end
  end
end
