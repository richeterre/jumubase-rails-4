class Performance < ActiveRecord::Base
  belongs_to :contest_category
  belongs_to :predecessor, class_name: 'Performance'
  has_many :appearances, dependent: :destroy
  has_many :participants, through: :appearances
  has_many :pieces, dependent: :destroy

  delegate :contest, to: :contest_category

  validates :contest_category, presence: true
end
