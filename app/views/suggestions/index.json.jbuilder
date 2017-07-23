json.array!(@suggestions) do |suggestion|
  json.extract! suggestion, :id, :title, :description, :creator_id, :team_member_id, :status_id, :completion_date, :notes
  json.url suggestion_url(suggestion, format: :json)
end
