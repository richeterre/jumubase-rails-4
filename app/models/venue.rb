# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  host_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_venues_on_host_id  (host_id)
#

class Venue < ActiveRecord::Base
  belongs_to :host

  validates :name, presence: true
  validates :host, presence: true
end
