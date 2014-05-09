json.array!(@games) do |game|
  json.extract! game, :id, :gameid, :user1, :user1progress, :user2, :user2progress
  json.url game_url(game, format: :json)
end
