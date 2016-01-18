class Performance < ActiveRecord::Base
  belongs_to :contest
  belongs_to :predecessor, class_name: 'Performance'

  validates :contest, presence: true
end
