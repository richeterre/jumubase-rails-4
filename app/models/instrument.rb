# == Schema Information
#
# Table name: instruments
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Instrument < ActiveRecord::Base
  validates :name, presence: true
end
