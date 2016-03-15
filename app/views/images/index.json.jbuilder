json.array!(@images) do |image|
  json.extract! image, :id, :album_id, :asset, :title
  json.url image_url(image, format: :json)
end
