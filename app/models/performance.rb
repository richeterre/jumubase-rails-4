class Performance < ActiveRecord::Base
  belongs_to :contest_category
  belongs_to :predecessor, class_name: 'Performance'
  delegate :contest, to: :contest_category

  validates :contest_category, presence: true
end
