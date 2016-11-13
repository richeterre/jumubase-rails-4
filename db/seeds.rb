# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
when "development"
  FactoryGirl.create(:admin,
    first_name: "Martin",
    last_name: "Richter",
    email: "me@martinrichter.net",
    password: "jumubase",
  )

  contest = FactoryGirl.create(:contest, season: JUMU_SEASON)
  contest_category = FactoryGirl.create(:contest_category, contest: contest)
  FactoryGirl.create(:performance, contest_category: contest_category)
end
