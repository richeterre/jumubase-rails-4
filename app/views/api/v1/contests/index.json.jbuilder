json.array! @contests do |contest|
  json.id contest.id.to_s
  json.name contest.name
  json.time_zone contest.host.time_zone

  json.contest_categories contest.contest_categories do |contest_category|
    json.id contest_category.id.to_s
    json.name contest_category.category.name
  end

  json.venues contest.venues do |venue|
    json.id venue.id.to_s
    json.name venue.name
  end
end
