class Event < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100  }, presence: true
  validates :content, length: { maximum: 200 }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
