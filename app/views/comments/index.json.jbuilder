json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :comment, :subject, :is_update, :progress
  json.url comment_url(comment, format: :json)
end
