require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'バリデーション' do
    context '#comment' do
      context '31文字以上の時' do
        let(:ticket) { build(:ticket, comment: 'a' * 31) }
        it 'バリデーションエラーとなること' do
          expect(ticket).to be_invalid(:comment)
        end
      end
    end
  end
end
