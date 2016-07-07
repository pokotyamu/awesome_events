module RequestsSupport
  shared_examples_for 'HTTP 200 OK' do
    it '200 OK で応答すること' do
      subject
      expect(response).to have_http_status 200
    end
  end

  shared_examples_for 'HTTP 201 Created' do
    it '201 Createdで応答すること' do
      subject
      expect(response).to have_http_status 201
    end
  end

  shared_examples_for 'HTTP 302 Found' do
    it '302 Found で応答すること' do
      subject
      expect(response).to have_http_status 302
    end
  end

  shared_examples_for 'HTTP 400 Bad Request' do
    it '400 Bad Request で応答すること' do
      subject
      expect(response).to have_http_status 400
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

  shared_examples_for 'flash notice' do
    it "期待したflash メッセージが用意されていること" do
      subject
      expect(flash[:notice]).to eq message
    end
  end

  shared_examples_for 'flash alert' do
    it "期待したflash メッセージが用意されていること" do
      subject
      expect(flash[:alert]).to eq message
    end
  end
end
