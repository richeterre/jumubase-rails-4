json.contests @contests do |contest|
  json.id contest.id.to_s
  json.name contest.name

  json.performances contest.performances do |performance|
    json.name "Performance #{performance.id}"
  end
end
