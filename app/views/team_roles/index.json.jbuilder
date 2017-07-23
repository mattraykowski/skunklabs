json.array!(@team_roles) do |team_role|
  json.extract! team_role, :id, :lab_id, :role_type_id, :user_id, :comment
  json.url team_role_url(team_role, format: :json)
end
