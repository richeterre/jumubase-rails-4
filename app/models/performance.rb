# == Schema Information
#
# Table name: performances
#
#  id                  :integer          not null, primary key
#  predecessor_id      :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contest_category_id :integer          not null
#  stage_time          :datetime
#  stage_venue_id      :integer
#  edit_code           :string           not null
#

class Performance < ActiveRecord::Base
  belongs_to :contest_category
  belongs_to :predecessor, class_name: 'Performance'
  belongs_to :stage_venue, class_name: 'Venue'
  has_many :appearances, inverse_of: :performance, dependent: :destroy
  has_many :pieces, dependent: :destroy

  delegate :contest, to: :contest_category
  delegate :category, to: :contest_category

  accepts_nested_attributes_for :appearances

  validates :contest_category, presence: true
  validates :edit_code, uniqueness: true
  validate :check_role_combinations
  validate :check_multiple_participant_appearances

  before_validation :set_unique_edit_code, on: :create

  private

    def check_role_combinations
      # TODO: Handle appearances marked for destruction

      # Check if there are any appearances at all
      if appearances.empty?
        errors.add(:base, :must_have_some_participant)
      end

      # Check if there are many soloists
      if appearances.select { |a| a.solo? }.size > 1
        errors.add(:base, :cannot_have_many_soloists)
      end

      # Check if all participants are accompanists
      if !appearances.empty? && appearances.all? {|a| a.accompaniment? }
        errors.add(:base, :cannot_have_mere_accompanists)
      end

      # Check if there is a lonely ensemblist
      if appearances.size == 1 && appearances.all? {|a| a.ensemble? }
        errors.add(:base, :cannot_have_single_ensemblist)
      end

      # Check if there are both soloists and ensemblists
      has_soloists = appearances.select {|a| a.solo? }.size > 0
      has_ensemblists = appearances.select {|a| a.ensemble? }.size > 0
      if has_soloists && has_ensemblists
        errors.add(:base, :cannot_have_soloists_and_ensemblists)
      end
    end

    def check_multiple_participant_appearances
      # Check if the same participant appears multiple times
      if appearances.group_by { |a| a.participant_id }.any? { |k, v| v.size > 1 }
        errors.add(:base, :cannot_have_same_participant_appear_multiple_times)
      end
    end

    def set_unique_edit_code
      begin
        code = rand(10000..99999).to_s
      end while Performance.where(edit_code: code).exists?

      self.edit_code = code
    end
end
