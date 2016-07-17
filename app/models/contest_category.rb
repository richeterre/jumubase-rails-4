# == Schema Information
#
# Table name: contest_categories
#
#  id          :integer          not null, primary key
#  contest_id  :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_contest_categories_on_category_id  (category_id)
#  index_contest_categories_on_contest_id   (contest_id)
#

class ContestCategory < ActiveRecord::Base
  belongs_to :contest
  belongs_to :category
  has_many :performances, dependent: :destroy
end
