# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    association :event, factory: :future_event
    user
    sequence(:comment) { |i| "コメント#{i}" }
  end
end
