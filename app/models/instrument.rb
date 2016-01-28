class Instrument < ActiveRecord::Base
  validates :name, presence: true
end
