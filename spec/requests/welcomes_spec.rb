require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /" do
    subject { get '/' }

    let(:template) { 'index' }

    it_behaves_like 'HTTP 200 OK'
    it_behaves_like 'render template'
  end
end
