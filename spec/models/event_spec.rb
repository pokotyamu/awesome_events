require 'rails_helper'

describe Event, type: :model do

  describe '#guest?(user)' do
    subject { event.guest?(user) }

    let(:event) { create(:future_event) }
    let(:user) { create(:user) }
    let!(:ticket) { create(:ticket, event: event, user: user)}

    context 'user がイベントに参加している時' do
      it 'ticket が返ること' do
        expect(subject).to eq ticket
      end
    end

    context 'user がイベントに参加していない時' do
      before { ticket.destroy }
      it 'nil が返ること' do
        expect(subject).to be_nil
      end
    end
  end


  describe '#name' do
    it '空白である時validationエラーとなる' do
      should validate_presence_of(:name)
    end

    it '50文字以上の時validationエラーとなる' do
      should ensure_length_of(:name).is_at_most(50)
    end
  end

  describe '#place' do
    it '空白である時validationエラーとなる' do
      should validate_presence_of(:place)
    end

    it '100文字以上の時validationエラーとなる' do
      should ensure_length_of(:place).is_at_most(100)
    end
  end

  describe '#content' do
    it '空白である時validationエラーとなる' do
      validate_presence_of(:content)
    end

    it '100文字以上の時validationエラーとなる' do
      should ensure_length_of(:content).is_at_most(2000)
    end
  end

  describe '#strat_time' do
    it '空白である時validationエラーとなる' do
      should validate_presence_of(:start_time)
    end
  end

  describe '#end_time' do
    it '空白である時validationエラーとなる' do
      should validate_presence_of(:end_time)
    end
  end

  describe 'start_time が end_time' do
    context 'より早い時' do
      it '正常に動作する' do
        event = Event.new(start_time: Time.local(2015, 5, 20, 23, 59, 59), end_time: Time.local(2015, 5, 21, 23, 59, 59))
        event.valid?
        expect(event.errors[:start_time]).to be_blank
      end
    end
    context 'と同じ時' do
      it 'validationエラーとなる' do
        event = Event.new(start_time: Time.local(2015, 5, 21, 23, 59, 59), end_time: Time.local(2015, 5, 21, 23, 59, 59))
        event.valid?
        expect(event.errors[:start_time]).to be_present
      end
    end

    context 'より遅い時' do
      it 'validationエラーとなる' do
        event = Event.new(start_time: Time.local(2015, 5, 21, 23, 59, 59), end_time: Time.local(2015, 5, 20, 23, 59, 59))
        event.valid?
        expect(event.errors[:start_time]).to be_present
      end
    end
  end

  describe 'リレーション' do
    it { should belong_to(:owner) }
    it { should have_many(:tickets) }
  end
end
