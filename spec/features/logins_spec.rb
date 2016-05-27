require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  describe 'ユーザがイベントの参加や登録を行うために、ログインをする' do
    context 'トップページに遷移し、"Twitterでログイン"をクリックした時' do
      context 'かつTwitterでログインに成功した時' do
        before do
          visit root_path
          click_link 'Twitterでログイン'
        end

        it 'トップページに遷移していること' do
          expect(page.current_path).to eq root_path
        end

        it '"ログインしました"と表示されること' do
          expect(page).to have_content 'ログインしました'
        end
      end
    end
  end
end
