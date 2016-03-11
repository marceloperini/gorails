json.array!(@link_categories) do |link_category|
  json.extract! link_category, :id, :name
  json.url link_category_url(link_category, format: :json)
end
