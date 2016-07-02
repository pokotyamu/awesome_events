require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'バリデーション' do
    context '#comment' do
      context '31文字以上の時' do
        let(:ticket) { build(:ticket, comment: 'a' * 31) }
        it 'invalid となること' do
          expect(ticket).to be_invalid(:comment)
        end
      end

      context '空白の時' do
        let(:ticket) { build(:ticket, comment: '') }
        it 'valid となること' do
          expect(ticket).to be_valid(:comment)
        end
      end
    end
  end
end
