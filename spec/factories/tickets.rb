# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    user nil
    event nil
    comment "MyString"
  end
end
