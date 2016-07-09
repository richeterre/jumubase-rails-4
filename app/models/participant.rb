# == Schema Information
#
# Table name: participants
#
#  id           :integer          not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  birthdate    :date             not null
#  street       :string
#  postal_code  :string
#  city         :string
#  country_code :string           not null
#  phone        :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Participant < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validates :country_code, presence: true
  validates :phone, presence: true
  validates :email, presence: true, format: { with: email_regex }

  def full_name
    "#{first_name} #{last_name}"
  end
end
