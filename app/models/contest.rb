class Contest < ActiveRecord::Base
  include JumuHelper

  belongs_to :host
  has_many :performances

  validates :season, presence: true
  validates :level, inclusion: { in: 1..3 }
  validates :host, presence: true
  validates :begins, presence: true
  validates :ends, presence: true
  validates :signup_deadline, presence: true

  validate :require_beginning_before_end
  validate :require_signup_deadline_before_beginning

  def name
    "#{self.host.name}, #{short_name_for_level(self.level)} #{year_for_season(self.season)}"
  end

  private

    def require_beginning_before_end
      unless begins.nil? || ends.nil?
        errors.add(:base, :beginning_not_before_end) if ends < begins
      end
    end

    def require_signup_deadline_before_beginning
      unless begins.nil? || signup_deadline.nil?
        errors.add(:base, :signup_deadline_not_before_beginning) unless signup_deadline < begins
      end
    end
end
