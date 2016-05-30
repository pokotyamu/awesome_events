require 'rails_helper'

describe Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
  end
end
