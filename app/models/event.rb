class Event < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
end
