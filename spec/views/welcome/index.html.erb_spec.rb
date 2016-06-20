require 'rails_helper'

RSpec.describe "welcome/index", type: :view do
  context 'ログインユーザがアクセスした時' do

      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:user_events) { create_list(:future_event, 5, owner_id: user.id) }
      let(:other_events) { create_list(:future_event, 5, owner_id: other_user.id) }

      before do
        def view.logged_in?
        end

        def view.current_user
        end

        allow(view).to receive(:logged_in?) { true }
        allow(view).to receive(:current_user) { user }
        session[:user_id] = user.id
        assign(:events, user_events + other_events)
        render
      end

      it 'まだ開催していないイベント一覧が表示されている' do
        user_events.each do |event|
          expect(rendered).to match(/#{ event.name }/)
        end

        other_events.each do |event|
          expect(rendered).to match(/#{ event.name }/)
        end
      end

      context 'ログインユーザが作成したイベントが存在するとき' do
        it 'そのイベントに対する「編集」ボタンが表示されている' do
          user_events.each do |event|
            expect(rendered).to match(/<a class=\"btn btn-info btn-lg btn-block\" href=\"\/events\/#{event.id}\/edit\">編集<\/a>/)
          end
        end
      end
  end
end
