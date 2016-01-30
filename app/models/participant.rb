class Participant < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validates :country_code, presence: true
  validates :phone, presence: true
  validates :email, presence: true, format: { with: email_regex }
end
