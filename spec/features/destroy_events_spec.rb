require 'rails_helper'

RSpec.feature "DestroyEvents", type: :feature do
  describe 'ユーザがイベントの削除を行う時' do
    let!(:user) { create(:user) }
    let!(:user_event) { create(:future_event, owner_id: user.id) }

    before do
      allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context 'かつ、イベント一覧ページから行う時' do
      before do
        visit root_path
        click_link '削除'
      end

      context 'かつ、削除確認で「ok」を押した時' do
        before do
          click_button 'ok'
        end

        it 'イベント一覧ページが表示されていること' do
          expect(page).to have_content /イベント一覧/
        end

        it '"削除しました"と表示されてること' do
          expect(page).to have_content /削除しました/
        end
      end

      context 'かつ、削除確認で「キャンセル」を押した時' do
        before do
          click_button 'キャンセル'
        end

        it 'イベント一覧ページが表示されていること' do
          expect(page).to have_content /イベント一覧/
        end
      end
    end

    context 'かつ、イベント詳細ページから行う時' do
      before do
        visit event_path(id: user_event.id)
        click_link 'イベントを削除する'
      end

      context 'かつ、削除確認で「ok」を押した時' do
        before do
          click_button 'ok'
        end

        it 'イベント一覧ページが表示されていること' do
          expect(page).to have_content /イベント一覧/
        end

        it '"削除しました"と表示されてること' do
          expect(page).to have_content /削除しました/
        end
      end

      context 'かつ、削除確認で「キャンセル」を押した時' do
        before do
          click_button 'キャンセル'
        end

        it 'そのイベントの詳細ページが表示されていること' do
          expect(page).to have_content /"#{event.name}"/
        end
      end
    end
  end
end
