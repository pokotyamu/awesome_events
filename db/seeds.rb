# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(id: 1, provider: "twitter", uid: "138393532", nickname: "pokotyamu", image_url: "http://pbs.twimg.com/profile_images/715666502393856001/SlLll-Z-_normal.jpg")
FactoryGirl.create(:user)

4.times do
  FactoryGirl.create(:future_event, owner_id: 1)
  FactoryGirl.create(:future_event, owner_id: 2)
end
