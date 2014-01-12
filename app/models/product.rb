class Product < ActiveRecord::Base

  has_and_belongs_to_many :products
  mount_uploader :image, ImageUploader

  def self.find_product_by_id_or_create_new_one(product_id, product_json)
    product = Product.find_by_product_id(product_id)
    if product.nil?
      begin
        product_json = RedboxApi.get_product_by_id(product_id)
        rt_json = RottenTomatoesApi.get_reviews_by_title(product_json["Products"]["Movie"]["Title"])
        puts product_json["Products"]["Movie"]["Title"]
        product = Product.create!(
        :remote_image_url => product_json["Products"]["Movie"]["BoxArtImages"]["link"][0]["@href"],
        # :image_url => product_json["Products"]["Movie"]["BoxArtImages"]["link"][0]["@href"],
        :product_id => product_json["Products"]["Movie"]["@productId"],
        :title => product_json["Products"]["Movie"]["Title"],
        :synopsis => product_json["Products"]["Movie"]["SynopsisShort"],
        :genre => product_json["Products"]["Movie"]["Genres"]["Genre"],
        :rated => product_json["Products"]["Movie"]["MPAARating"],
        :actors => product_json["Products"]["Movie"]["Actors"]["Person"].join(", "),
        :directors => Array(product_json["Products"]["Movie"]["Directors"]["Person"]).join(", "),
        :release_year => product_json["Products"]["Movie"]["ReleaseYear"],
        :critics_rating => rt_json["movies"][0]["ratings"]["critics_rating"],
        :critics_score => rt_json["movies"][0]["ratings"]["critics_score"],
        :audience_rating => rt_json["movies"][0]["ratings"]["audience_rating"],
        :audience_score => rt_json["movies"][0]["ratings"]["audience_score"]
        )
      rescue
        # do nothing for now
      end
    end
    return product
  end

end
