require 'spec_helper'

describe Store do
  it "should do have and belong to products" do
    product1 = Product.create!(:title => "Gone with the wined", :product_id => "xyz")
    store = Store.create!(:store_id => "123")
    store.products << product1
    store.products.should == [product1]
  end
  it "should be able to delete the products" do
    store = Store.create!(:store_id => "123")
    3.times.each do
      product = Product.create!(:title => "Gone with the wined", :product_id => "xyz")
      store.products << product
    end
    store.products.count.should == 3
    store.products.destroy_all
    store.products.count.should == 0
    Product.count.should == 3
    Store.count.should == 1
  end
end