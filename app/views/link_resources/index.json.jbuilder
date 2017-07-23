json.array!(@link_resources) do |link_resource|
  json.extract! link_resource, :id, :lab_id, :url, :description
  json.url link_resource_url(link_resource, format: :json)
end
