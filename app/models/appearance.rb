class Appearance < ActiveRecord::Base
  belongs_to :performance
  belongs_to :participant
  belongs_to :instrument

  validates :performance, presence: true
  validates :participant, presence: true
  validates :instrument, presence: true
  validates :participant_role,
    presence: true,
    inclusion: { in: JUMU_PARTICIPANT_ROLES }
end
