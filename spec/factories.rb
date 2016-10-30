FactoryGirl.define do
  factory :appearance do
    performance
    participant
    instrument
    participant_role JUMU_PARTICIPANT_ROLES.first
  end

  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    slug { name.parameterize }
    genre "classical"
    solo true
    ensemble false
  end

  factory :contest do
    sequence(:season)
    level 1
    host
    begins { Date.new(year_for_season(season), 1, 1) }
    ends { begins + 1.day }
    certificate_date { ends }
    signup_deadline { begins - 1.month }
  end

  factory :contest_category do
    contest
    category
  end

  factory :host do
    sequence(:name) { |n| "Host #{n}" }
    city "Helsinki"
    country_code "FI"
    time_zone "Europe/Helsinki"
  end

  factory :instrument do
    sequence(:name) { |n| "Instrument #{n}" }
  end

  factory :participant do
    first_name "Participant"
    sequence(:last_name) { |n| "#{n}" }
    birthdate "2000-01-01"
    phone "12345"
    email { "#{first_name}.#{last_name}@example.org".downcase }
  end

  factory :performance do
    contest_category

    after(:build) do |p|
      p.appearances << FactoryGirl.build(:appearance, performance: p) if p.appearances.empty?
      p.pieces << [FactoryGirl.build(:piece, performance: p)] if p.pieces.empty?
    end
  end

  factory :piece do
    performance
    title "4′33″"
    composer_name "John Cage"
    epoch "f"
    minutes 4
    seconds 33
  end

  factory :user do
    first_name "User"
    sequence(:last_name) { |n| "#{n}" }
    sequence(:email) { |n| "user-#{n}@example.org" }
    password "password"
    role "regular"

    factory :inspector do
      role "inspector"
    end

    factory :admin do
      role "admin"
    end
  end

  factory :venue do
    sequence(:name) { |n| "Venue #{n}" }
    host
  end
end
