class Performance < ActiveRecord::Base
  belongs_to :contest_category
  belongs_to :predecessor, class_name: 'Performance'
  has_many :appearances, dependent: :destroy
  has_many :pieces, dependent: :destroy

  delegate :contest, to: :contest_category

  validates :contest_category, presence: true
  validate :check_role_combinations

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
      if appearances.all? {|a| a.accompaniment? }
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
end
