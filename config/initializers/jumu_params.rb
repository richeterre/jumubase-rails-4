# Jumu-related parameters are defined here.
# Be sure to restart the server after changing any of these.
# Before changing anything, make sure you know what you're doing!

# The running number of the current competition season
JUMU_SEASON = Integer(ENV['JUMU_CURRENT_SEASON'])

# The current competition (ending) year
JUMU_YEAR = 1963 + JUMU_SEASON

# The short names of the different rounds
JUMU_ROUND_SHORT_NAMES = {
  1 => "RW",
  2 => "LW",
  3 => "BW"
}

# Possible user role values for the database
JUMU_USER_ROLES = %w(regular inspector admin)

# Possible participant role values for the database
JUMU_PARTICIPANT_ROLES = %w(soloist ensemblist accompanist)

# Possible category genre values for the database
JUMU_GENRES = %w(classical popular kimu)

# Possible piece epoch values for the database
JUMU_EPOCHS = %w(a b c d e f)

# Possible age group values for the database
JUMU_AGE_GROUPS = %w(Ia Ib II III IV V VI VII)
