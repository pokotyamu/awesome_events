require 'rails_helper'

RSpec.feature "NewEvents", type: :feature do
  describe 'ユーザが"イベントを作る"をクリックした時' do
    context 'ログインしていないユーザの時' do
      before do
        visit root_path
        click_link 'イベントを作る'
      end

      it '"ログインしてください"というアラートが表示されること' do
        expect(page).to have_content 'ログインしてください'
      end

      it 'トップページに戻ること' do
        expect(page.current_path).to eq root_path
      end
    end

    context 'ログインしているユーザの時' do
      before do
        visit root_path
        click_link 'Twitterでログイン'
        click_link 'イベントを作る'
      end

      it '新規イベント作成画面に遷移すること' do
        expect(page.current_path).to eq new_event_path
      end

      context 'かつ、作成ボタンを押した時に、イベントの属性に不備があった時' do
        before do
          click_button "作成"
        end

        it '新規イベント作成画面に遷移すること' do
          expect(page.current_path).to eq '/events'
        end

        it 'エラーの内容が表示されていること' do
          expect(page).to have_content /名前を入力してください/
          expect(page).to have_content /場所を入力してください/
          expect(page).to have_content /内容を入力してください/
          expect(page).to have_content /開始時間は終了時間よりも前に設定してください/
        end
      end

      context 'かつ、作成ボタンを押した時に、不備なくイベントの属性が入力されている時' do
        before do
          fill_in "event_name", with: "テストイベント"
          fill_in "event_place", with: "テスト開催場所"
          fill_in "event_content", with: "テスト説明文"
          select '2016', from: 'event_start_time_1i'
          select 'June', from: 'event_start_time_2i'
          select '6', from: 'event_start_time_3i'
          select '00', from: 'event_start_time_4i'
          select '00', from: 'event_start_time_5i'
          select '2017', from: 'event_end_time_1i'
          select 'June', from: 'event_end_time_2i'
          select '6', from: 'event_end_time_3i'
          select '00', from: 'event_end_time_4i'
          select '00', from: 'event_end_time_5i'
          click_button '作成'
        end

        it '作成したイベントの詳細ぺージに遷移していること' do
          expect(page.current_path).to eq event_path(id: Event.last.id)
        end
      end
    end
  end
end
