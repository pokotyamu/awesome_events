module RequestsSupport
  shared_examples_for 'HTTP 200 OK' do
    it '200 OK で応答すること' do
      subject
      expect(response).to have_http_status 200
    end
  end
end
