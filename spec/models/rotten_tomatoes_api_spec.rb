require 'spec_helper'

describe RottenTomatoesApi do
  it "should find reviews based on movie title" do
    title = "Jaws"
    rt_json = File.read("#{Rails.root}/spec/fixtures/rotten_tomatoes.json") # use this as example
    stub_request(:get, "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=rfyzubcz3ej4fswabzfvsvnp&page_limit=1&q=Jaws").
         with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => rt_json, :headers => {})
    RottenTomatoesApi.get_reviews_by_title(title).should_not be_nil
  end
end