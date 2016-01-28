class Venue < ActiveRecord::Base
  belongs_to :host

  validates :name, presence: true
  validates :host, presence: true
end
