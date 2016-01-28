FactoryGirl.define do
  factory :contest do
    season 1
    level 1
    host
    begins "2016-01-15"
    ends "2016-01-16"
    certificate_date "2016-01-16"
    signup_deadline "2015-12-16 00:00:00"
  end

  factory :host do
    name "DS Helsinki"
    city "Helsinki"
    country_code "FI"
    time_zone "Europe/Helsinki"
  end

  factory :performance do
    contest
  end

  factory :piece do
    performance
    title "4‘33“"
    composer_name "John Cage"
    epoch "f"
    minutes 4
    seconds 33
  end

  factory :venue do
    name "Aula"
    host
  end
end
