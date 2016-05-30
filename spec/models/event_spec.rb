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
    it { should ensure_length_of(:content).is_at_most(200) }
  end

  describe '#strat_time' do
    it { should validate_presence_of(:start_time) }
  end

  describe '#end_time' do
    it { should validate_presence_of(:end_time) }
  end
end
