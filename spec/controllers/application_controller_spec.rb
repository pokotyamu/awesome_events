require "rails_helper"

describe ApplicationController do
  describe '#current_user' do
    context 'ユーザがログインしていない時' do
      it 'nil が返ること' do
        expect(subject.current_user).to be_nil
      end
    end

    context 'ユーザがログインしている時' do
      let(:user) { create(:user) }

      before do
        set_up_loggin(user, true)
      end

      it 'ログインユーザのインスタンスが返る' do
        expect(subject.current_user.id).to eq(user.id)
      end
    end
  end
end
