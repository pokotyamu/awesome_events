module RequestsSupport
  shared_examples_for 'HTTP 200 OK' do
    it '200 OK で応答すること' do
      subject
      expect(response).to have_http_status 200
    end
  end

  shared_examples_for 'HTTP 302 Found' do
    it '302 Found で応答すること' do
      subject
      expect(response).to have_http_status 302
    end
  end

  shared_examples_for 'render template' do
    it "期待したテンプレートを render していること" do
      subject
      expect(response).to render_template("#{template}".to_sym)
    end
  end

  shared_examples_for 'redirect' do
    it "期待したパスに redirect していること" do
      subject
      expect(response).to redirect_to redirect_path
    end
  end
end
