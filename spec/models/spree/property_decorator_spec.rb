require 'spec_helper'

describe Spree::Property do

  before :each do
    Rails.cache.clear
  end

  let(:product) { create(:product) }
  let(:product_property) { create(:product_property, product: product, value: "Test") }
  let(:property) { product_property.property }

  describe "#bust_product_properties_cache" do

    it "will be called on touch" do
      property.should_receive(:bust_product_properties_cache)
      property.touch
    end

    it "will invalidate each products property cache" do
      Rails.cache.should_receive(:delete).at_least(1).times
      property.touch
    end

  end

end