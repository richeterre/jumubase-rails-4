# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  genre      :string           not null
#  solo       :boolean          not null
#  ensemble   :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :slug, presence: true
  validates :genre, inclusion: { in: JUMU_GENRES }
  validates :solo, inclusion: { in: [true, false] }
  validates :ensemble, inclusion: { in: [true, false] }
end
