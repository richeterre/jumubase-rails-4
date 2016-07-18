json.contests @contests do |contest|
  json.id contest.id.to_s
  json.name contest.name
  json.time_zone contest.host.time_zone

  json.venues contest.venues do |venue|
    json.id venue.id.to_s
    json.name venue.name
  end
end
