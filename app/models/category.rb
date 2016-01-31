class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :slug, presence: true
  validates :genre, presence: true
  validates :solo, inclusion: { in: [true, false] }
  validates :ensemble, inclusion: { in: [true, false] }
end
