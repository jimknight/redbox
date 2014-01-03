require 'spec_helper'

describe Store do
  it "should do have and belong to products" do
    product1 = Product.create!(:title => "Gone with the wined", :product_id => "xyz")
    store = Store.create!(:store_id => "123")
    store.products << product1
    store.products.should == [product1]
  end
end