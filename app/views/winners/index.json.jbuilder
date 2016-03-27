json.array!(@winners) do |winner|
  json.extract! winner, :id, :gift_id, :user_id
  json.url winner_url(winner, format: :json)
end
