class Piece < ActiveRecord::Base
  belongs_to :performance

  validates :performance, presence: true
  validates :title, presence: true
  validates :composer_name, presence: true
  validates :epoch, presence: true
  validates :minutes,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than: 60
    }
  validates :seconds,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than: 60
    }
end
