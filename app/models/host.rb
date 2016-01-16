class Host < ActiveRecord::Base
  validates :name, presence: true
  validates :city, presence: true
  validates :country_code, format: { with: /\A[A-Z]{2}\z/ }
  validates :time_zone, presence: true
end
