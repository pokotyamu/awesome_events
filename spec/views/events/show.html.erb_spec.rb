require "rails_helper"

RSpec.describe "events/show", type: :view do
  context '存在するページにユーザがアクセスした時' do
    let(:event) { create(:future_event) }
    before do
      assign(:event, event)
      render
    end

    it '選択されたEvent のイベント名が表示されていること' do
      expect(rendered).to match(/#{event.name}/)
    end

    it '選択されたEvent の主催者名が表示されていること' do
      expect(rendered).to match(/@#{User.find(event.owner_id).nickname}/)
    end

    it '選択されたEvent の開催時間が表示されていること' do
      expect(rendered).to match(/#{event.start_time.strftime('%Y/%m/%d %H:%M')} - #{event.end_time.strftime('%Y/%m/%d %H:%M')}/)
    end

    it '選択されたEvent の開催場所が表示されていること' do
      expect(rendered).to match(/#{event.place}/)
    end

    it '選択されたEvent のイベント内容が表示されていること' do
      expect(rendered).to match(/#{event.content}/)
    end

    context '選択されたEvent の主催者がログインユーザの時' do
      it '"イベントを編集する"が表示されていること'
    end

    context '選択されたEvent の主催者がログインユーザ以外の時' do
      it '"イベントを編集する"が表示されていないこと'
    end
  end

  context '存在しないページにユーザがアクセスした時' do
    before do
      visit event_path(0)
    end

    it 'トップぺージがrender されていること' do
      expect(page.current_path).to match root_path
    end

    it '"そのイベントは存在しません"とアラートが表示されること' do
      expect(page.body).to have_content /そのイベントは存在しません/
    end
  end
end
