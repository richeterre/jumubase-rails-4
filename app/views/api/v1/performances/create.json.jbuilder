json.id @performance.id
json.category_name @performance.category.name
json.appearances @performance.appearances do |appearance|
  json.participant_id appearance.participant.id.to_s
  json.participant_name appearance.participant.full_name
  json.participant_role appearance.participant_role
  json.instrument_name appearance.instrument.name
end
