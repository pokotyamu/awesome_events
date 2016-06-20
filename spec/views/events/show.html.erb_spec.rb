require "rails_helper"

RSpec.describe "events/show", type: :view do
  context '存在するページにユーザがアクセスした時' do
    before do
      def view.logged_in?
      end

      def view.current_user
      end
    end

    context '選択されたEvent の主催者がログインユーザの時' do
      let(:user) { create(:user) }
      let(:user_event) { create(:future_event, owner_id: user.id) }

      before do
        allow(view).to receive(:logged_in?) { true }
        allow(view).to receive(:current_user) { user }
        session[:user_id] = user.id
        assign(:event, user_event)
        render
      end

      it '選択されたEvent のイベント名が表示されていること' do
        expect(rendered).to match(/#{user_event.name}/)
      end

      it '選択されたEvent の主催者名が表示されていること' do
        expect(rendered).to match(/@#{User.find(user_event.owner_id).nickname}/)
      end

      it '選択されたEvent の開催時間が表示されていること' do
        expect(rendered).to match(/#{user_event.start_time.strftime('%Y/%m/%d %H:%M')} - #{user_event.end_time.strftime('%Y/%m/%d %H:%M')}/)
      end

      it '選択されたEvent の開催場所が表示されていること' do
        expect(rendered).to match(/#{user_event.place}/)
      end

      it '選択されたEvent のイベント内容が表示されていること' do
        expect(rendered).to match(/#{user_event.content}/)
      end

      it '"イベントを編集する"が表示されていること' do
        expect(rendered).to match(/イベントを編集する/)
      end
    end

    context '選択されたEvent の主催者がログインユーザ以外の時' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:other_event) { create(:future_event, owner_id: other_user.id) }

      before do
        allow(view).to receive(:logged_in?) { false }
        allow(view).to receive(:current_user) { nil }
        assign(:event, other_event)
        render
      end

      it '選択されたEvent のイベント名が表示されていること' do
        expect(rendered).to match(/#{other_event.name}/)
      end

      it '選択されたEvent の主催者名が表示されていること' do
        expect(rendered).to match(/@#{User.find(other_event.owner_id).nickname}/)
      end

      it '選択されたEvent の開催時間が表示されていること' do
        expect(rendered).to match(/#{other_event.start_time.strftime('%Y/%m/%d %H:%M')} - #{other_event.end_time.strftime('%Y/%m/%d %H:%M')}/)
      end

      it '選択されたEvent の開催場所が表示されていること' do
        expect(rendered).to match(/#{other_event.place}/)
      end

      it '選択されたEvent のイベント内容が表示されていること' do
        expect(rendered).to match(/#{other_event.content}/)
      end

      it '"イベントを編集する"が表示されていないこと' do
        expect(rendered).not_to match(/イベントを編集する/)
      end
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
