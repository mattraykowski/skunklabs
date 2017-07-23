json.array!(@focus_types) do |focus_type|
  json.extract! focus_type, :id, :name, :description
  json.url focus_type_url(focus_type, format: :json)
end
