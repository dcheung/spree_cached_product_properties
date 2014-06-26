module Spree
  Property.class_eval do
    after_touch :bust_product_properties_cache

  private
    def bust_product_properties_cache
      products.each do |product|
        Rails.cache.delete(product.property_cache_key(name))
      end
    end
  end
end