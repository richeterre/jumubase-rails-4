class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :hosts

  validates :role,
    presence: true,
    inclusion: { in: JUMU_USER_ROLES }

  def has_role?(role)
    self.role == role.to_s
  end
end
