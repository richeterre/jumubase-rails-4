# == Schema Information
#
# Table name: hosts
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  city         :string           not null
#  country_code :string           not null
#  time_zone    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Host < ActiveRecord::Base
  has_many :venues

  validates :name, presence: true
  validates :city, presence: true
  validates :country_code, format: { with: /\A[A-Z]{2}\z/ }
  validates :time_zone, presence: true
end
