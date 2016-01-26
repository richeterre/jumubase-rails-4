json.contests @contests do |contest|
  json.name contest.name

  json.performances contest.performances do |performance|
    json.name "Performance #{performance.id}"
  end
end
