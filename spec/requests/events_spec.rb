require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe 'GET /events/:id' do
    context '存在するイベントにアクセスした時' do
      let(:event) { create(:future_event) }
      let(:template) { 'show' }
      subject { get "/events/#{event.id}"}

      it_behaves_like 'HTTP 200 OK'
      it_behaves_like 'render check'
    end

    context '存在しないイベントにアクセスした時' do
      let(:redirect_path) { root_path }
      subject { get "/events/100"}
      it_behaves_like 'HTTP 302 OK'
      it_behaves_like 'redirect'
    end
  end
end
