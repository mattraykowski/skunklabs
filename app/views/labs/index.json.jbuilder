json.array!(@labs) do |lab|
  json.extract! lab, :id, :user_id, :name, :goals, :measurements, :focus_area
  json.url lab_url(lab, format: :json)
end
