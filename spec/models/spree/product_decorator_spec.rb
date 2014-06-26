require 'spec_helper'

describe Spree::Product do

  before :each do
    Rails.cache.clear
  end

  let(:product) { create(:product) }
  let(:product_property) { create(:product_property, product: product, value: "Test") }
  let(:name) { product_property.property.name }

  describe "#property" do

    it "will fetch a product property by name" do
      product.property(name).should == product_property.value
    end

    it "will use a unique cache key to look up the value" do
      product.should_receive(:property_cache_key).with(name) { "product-#{product.id}-property-#{name}" }
      product.property(name)
    end

    it "will use the Rails cache to lookup the product property by name" do
      Rails.cache.should_receive(:fetch).with("product-#{product.id}-property-#{name}")
      product.property(name)
    end

  end

end