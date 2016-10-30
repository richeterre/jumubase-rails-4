module JumuHelper
  def short_name_for_round(round)
    return JUMU_ROUND_SHORT_NAMES[round]
  end

  def year_for_season(season)
    return JUMU_YEAR - JUMU_SEASON + season
  end

  def age_group_for_birthdates_and_season(birthdates, season)
    if birthdates.instance_of? Date
      # Skip averaging step if only one date
      avg_date = birthdates
    else
      # Convert dates to timestamps
      timestamps = birthdates.map{ |date| date.to_time.to_f }
      # Get "average" timestamp
      avg_timestamp = timestamps.sum / birthdates.size
      # Convert back to date
      avg_date = Time.at(avg_timestamp).to_date
    end
    # Return age group for that date
    age_group_for_date_and_season(avg_date, season)
  end

  def age_group_for_date_and_season(date, season)
    season_year = year_for_season(season)

    case date.year
    when (season_year - 8)..season_year
      JUMU_AGE_GROUPS[0]
    when (season_year - 10)..(season_year - 9)
      JUMU_AGE_GROUPS[1]
    when (season_year - 12)..(season_year - 11)
      JUMU_AGE_GROUPS[2]
    when (season_year - 14)..(season_year - 13)
      JUMU_AGE_GROUPS[3]
    when (season_year - 16)..(season_year - 15)
      JUMU_AGE_GROUPS[4]
    when (season_year - 18)..(season_year - 17)
      JUMU_AGE_GROUPS[5]
    when (season_year - 21)..(season_year - 19)
      JUMU_AGE_GROUPS[6]
    when (season_year - 27)..(season_year - 22)
      JUMU_AGE_GROUPS[7]
    end
  end
end
