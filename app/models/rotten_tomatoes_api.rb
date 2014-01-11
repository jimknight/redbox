class RottenTomatoesApi < ActiveRecord::Base

  @@rt_api_key = ENV["ROTTEN_TOMATOES_API_KEY"]

  def self.get_reviews_by_title(movie_title)
    # error trap needed
    movie_title = movie_title.gsub(" ","+")
    rt_api = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{@@rt_api_key}&q=#{movie_title}&page_limit=1"
    rt_get = open(rt_api,"Accept" => "application/json").read
    rt_json = JSON.parse(rt_get)
  end

end
