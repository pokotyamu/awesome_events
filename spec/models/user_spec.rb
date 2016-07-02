require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'バリデーション' do
    context 'provider' do
      context 'nil の時' do
        it 'バリデーションエラーとなること' do
          user.provider = nil
          expect(user).to be_valid
        end
      end
    end

    context 'uid' do
      context 'nil の時' do
        it 'バリデーションエラーとなること' do
          user.uid = nil
          expect(user).to be_valid
        end
      end
    end

    context 'nickname' do
      context 'nil の時' do
        it 'バリデーションエラーとなること' do
          user.nickname = nil
          expect(user).to be_valid
        end
      end
    end

    context 'image_url' do
      context 'nil の時' do
        it 'バリデーションエラーとなること' do
          user.image_url = nil
          expect(user).to be_valid
        end
      end
    end
  end

  describe 'リレーション' do
    it { should have_many(:created_events) }
    it { should have_many(:ticket) }
  end
end
