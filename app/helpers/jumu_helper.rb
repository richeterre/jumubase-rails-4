module JumuHelper
  def short_name_for_level(level)
    return JUMU_LEVEL_SHORT_NAMES[level]
  end

  def year_for_season(season)
    return JUMU_YEAR - JUMU_SEASON + season
  end
end
