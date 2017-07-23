json.array!(@suggestion_states) do |suggestion_state|
  json.extract! suggestion_state, :id, :name, :done
  json.url suggestion_state_url(suggestion_state, format: :json)
end
