class Host < ActiveRecord::Base
  validates :name, presence: true
  validates :city, presence: true
  validates :country_code, presence: true
  validates :time_zone, presence: true
end
