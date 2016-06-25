module RequestsSupport
  shared_examples_for 'HTTP 200 OK' do
    it '200 OK で応答すること' do
      subject
      expect(response).to have_http_status 200
    end
  end

  shared_examples_for 'HTTP 302 OK' do
    it '302 OK で応答すること' do
      subject
      expect(response).to have_http_status 302
    end
  end

  shared_examples_for 'render check' do
    it "テンプレートを render していること" do
    it "期待したテンプレートを render していること" do
      subject
      expect(response).to render_template("#{template}".to_s)
    end
  end
end
