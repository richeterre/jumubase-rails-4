require 'rails_helper'

RSpec.describe JumuHelper, type: :helper do

  it "should look up the age group for a given date and season" do
    dates = [
      Date.new(2007,1,1),
      Date.new(2006,1,1),
      Date.new(2005,1,1),
      Date.new(2004,1,1),
      Date.new(2003,1,1),
      Date.new(2002,1,1),
      Date.new(2001,1,1),
      Date.new(2000,1,1),
      Date.new(1999,1,1),
      Date.new(1998,1,1),
      Date.new(1997,1,1),
      Date.new(1996,1,1),
      Date.new(1995,1,1),
      Date.new(1994,1,1),
      Date.new(1993,1,1),
      Date.new(1992,1,1),
      Date.new(1991,1,1),
      Date.new(1990,1,1),
      Date.new(1989,1,1),
      Date.new(1988,1,1),
      Date.new(1987,1,1),
      Date.new(1986,1,1)
    ]
    season = 50 # See 50th anniversary rules for year-to-age-group mapping

    age_groups = dates.map { |date|
      age_group_for_date_and_season(date, season)
    }
    expect(age_groups).to eq([
      'Ia', 'Ia', 'Ia',
      'Ib', 'Ib',
      'II', 'II',
      'III', 'III',
      'IV', 'IV',
      'V', 'V',
      'VI', 'VI', 'VI',
      'VII', 'VII', 'VII', 'VII', 'VII', 'VII'
    ])
  end
end
