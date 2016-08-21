# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string           not null
#  first_name             :string           not null
#  last_name              :string           not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :hosts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role,
    presence: true,
    inclusion: { in: JUMU_USER_ROLES }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def admin?
    self.role == 'admin'
  end

  def inspector?
    self.role == 'inspector'
  end
end
