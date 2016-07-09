# == Schema Information
#
# Table name: appearances
#
#  id               :integer          not null, primary key
#  performance_id   :integer          not null
#  participant_id   :integer          not null
#  instrument_id    :integer          not null
#  participant_role :string           not null
#  points           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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

  def solo?
    participant_role == 'soloist'
  end

  def ensemble?
    participant_role == 'ensemblist'
  end

  def accompaniment?
    participant_role == 'accompanist'
  end
end
