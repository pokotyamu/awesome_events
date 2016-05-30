class Event < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100  } ,presence: true
end
