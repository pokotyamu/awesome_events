require "rails_helper"

RSpec.describe "events/show", type: :view do
  context 'ユーザがアクセスした時' do
    let(:event) { create(:event) }
    before do
      assign(:event, event)
      render
    end
    it 'Event の:id 番目のイベント名が表示されていること' do
      expect(rendered).to match(/"#{assigns(:event).name}"/)
    end
    it 'Event の:id 番目の主催者名が表示されていること' do
      expect(rendered).to match(/"@#{assigns(:event).nickneme}"/)
    end
    it 'Event の:id 番目の開催時間が表示されていること' do
      expect(rendered).to match(/"#{assigns(:event).start_time.strftime('%Y/%m/%d %H:%M') - assigns(:event).end_time.strftime('%Y/%m/%d %H:%M') }"/)
    end
    it 'Event の:id 番目の開催場所が表示されていること' do
      expect(rendered).to match(/"#{assigns(:event).place}"/)
    end
    it 'Event の:id 番目のイベント内容が表示されていること' do
      expect(rendered).to match(/"#{assigns(:event).content}"/)
    end
  end
end
