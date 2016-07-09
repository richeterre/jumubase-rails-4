# == Schema Information
#
# Table name: pieces
#
#  id             :integer          not null, primary key
#  performance_id :integer          not null
#  title          :string           not null
#  composer_name  :string           not null
#  composer_born  :string
#  composer_died  :string
#  epoch          :string           not null
#  minutes        :integer          not null
#  seconds        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_pieces_on_performance_id  (performance_id)
#

class Piece < ActiveRecord::Base
  belongs_to :performance

  validates :performance, presence: true
  validates :title, presence: true
  validates :composer_name, presence: true
  validates :epoch,
    presence: true,
    inclusion: { in: JUMU_EPOCHS }

  validates :minutes,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than: 60
    }
  validates :seconds,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than: 60
    }
end
