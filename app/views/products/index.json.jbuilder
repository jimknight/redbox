json.array!(@products) do |product|
  json.extract! product, :id, :title, :synopsis, :genre, :rated, :actors, :directors, :release_year, :critics_rating, :critics_score, :audience_rating, :audience_score
  json.url product_url(product, format: :json)
end
