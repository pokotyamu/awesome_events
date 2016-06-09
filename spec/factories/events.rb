# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    trait :seq_info do
      owner
      sequence(:name) { |i| "イベント名#{i}" }
      sequence(:place) { |i| "イベント開催場所#{i}" }
      sequence(:content) { |i| "イベント本文#{i}" }
    end

    trait :rand_date do
      start_time { rand(1..30).days.from_now }
      end_time { start_time + rand(1..30).hours }
    end

    trait :fin_date do
      start_time { Time.local(Time.now.year - 1, 5, 2, 12, 00, 00) }
      end_time { start_time + rand(1..30).hours }
    end

    factory :rand_event, traits:[:seq_info, :rand_date]
    factory :fin_event, traits:[:seq_info, :fin_date]
  end
end
