require 'rails_helper'

RSpec.describe JumuHelper, type: :helper do

  season = 50
  # 50th anniversary season's year-to-age-group mapping:
  #
  # 2005 or later: Ia
  # 2003, 2004: Ib
  # 2001, 2002: II
  # 1999, 2000: III
  # 1997, 1998: IV
  # 1995, 1996: V
  # 1992 to 1994: VI
  # 1986 to 1991: IV

  it "should look up the age group for a given date and season" do
    dates = [
      Date.new(2008,1,1),
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

    age_groups = dates.map { |date|
      age_group_for_date_and_season(date, season)
    }
    expect(age_groups).to eq([
      'Ia', 'Ia', 'Ia', 'Ia',
      'Ib', 'Ib',
      'II', 'II',
      'III', 'III',
      'IV', 'IV',
      'V', 'V',
      'VI', 'VI', 'VI',
      'VII', 'VII', 'VII', 'VII', 'VII', 'VII'
    ])
  end

  describe "for a single birthdate" do
    it "should return the age group of that birthdate" do

      # Test with two single, unrelated birthdates to check border case
      single_birthdates = [
        Date.new(2001, 1, 1),
        Date.new(2000, 12, 31)
      ]

      age_groups = single_birthdates.map { |birthdate|
        age_group_for_birthdates_and_season(birthdate, season)
      }

      expect(age_groups).to eq(['II', 'III'])
    end
  end

  describe "for an array of birthdates" do

    it "should return the age group of the birthdates' average date" do
      birthdates = [
          Date.new(2000, 12, 31),
          Date.new(2001, 1, 2)
        ]
        age_group = age_group_for_birthdates_and_season(birthdates, season)
        expect(age_group).to eq('II')
    end

    describe "on consecutive days around an age group boundary" do

      it "should return the age group of the earlier date" do
        birthdates = [
          Date.new(2000, 12, 31), # AG III territory
          Date.new(2001, 1, 1) # AG II territory
        ]
        age_group = age_group_for_birthdates_and_season(birthdates, season)
        expect(age_group).to eq('III')
      end
    end
  end
end
