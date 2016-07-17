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
# Indexes
#
#  index_appearances_on_instrument_id   (instrument_id)
#  index_appearances_on_participant_id  (participant_id)
#  index_appearances_on_performance_id  (performance_id)
#

class Appearance < ActiveRecord::Base
  belongs_to :performance, inverse_of: :appearances
  belongs_to :participant
  belongs_to :instrument

  accepts_nested_attributes_for :participant

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
