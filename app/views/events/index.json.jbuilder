json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :date, :local, :participants_limit
  json.url event_url(event, format: :json)
end
