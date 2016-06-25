require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    let!(:event) { create(:future_event) }
    subject { get "/events/#{event.id}"}

    it_behaves_like 'HTTP 200 OK'
  end
end
