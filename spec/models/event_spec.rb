require 'rails_helper'

describe Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(50) }
  end

  describe '#place' do
    it { should validate_presence_of(:place) }
    it { should ensure_length_of(:place).is_at_most(100) }
  end

  describe '#content' do
    it { should validate_presence_of(:content) }
    it { should ensure_length_of(:content).is_at_most(2000) }
  end

  describe '#strat_time' do
    it { should validate_presence_of(:start_time) }
  end

  describe '#end_time' do
    it { should validate_presence_of(:end_time) }
  end

  describe 'start_time と end_time の相関関係について' do
    context 'start_time と end_time を比べた時' do
      it 'strat_timeの方が早い時(正常系)' do
        event = Event.new(start_time: Time.local(2015, 5, 20, 23, 59, 59), end_time: Time.local(2015, 5, 21, 23, 59, 59))
        event.valid?
        expect(event.errors[:start_time]).to be_blank
      end

      it 'strat_time の方が遅い時' do
        event = Event.new(start_time: Time.local(2015, 5, 21, 23, 59, 59), end_time: Time.local(2015, 5, 20, 23, 59, 59))
        event.save
        expect(event.errors[:start_time]).to be_present
      end
    end
  end
end
