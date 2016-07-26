module JumuHelper
  def short_name_for_level(level)
    return JUMU_LEVEL_SHORT_NAMES[level]
  end

  def year_for_season(season)
    return JUMU_YEAR - JUMU_SEASON + season
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
