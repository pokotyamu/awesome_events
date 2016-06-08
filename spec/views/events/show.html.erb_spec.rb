require "rails_helper"

RSpec.describe "events/:id", type: :view do
  context 'ユーザがアクセスした時' do
    it 'Event の:id 番目のイベント名が表示されていること'
    it 'Event の:id 番目の主催者名が表示されていること'
    it 'Event の:id 番目の開催時間が表示されていること'
    it 'Event の:id 番目の開催場所が表示されていること'
    it 'Event の:id 番目のイベント内容が表示されていること'
  end
end
