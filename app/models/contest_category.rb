class ContestCategory < ActiveRecord::Base
  belongs_to :contest
  belongs_to :category
  has_many :performances
end
