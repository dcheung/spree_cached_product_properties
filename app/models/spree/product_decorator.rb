module Spree
  Product.class_eval do

    after_touch :clear_property_cache

    def property(name)
      Rails.cache.fetch(property_cache_key(name)) do
        product_properties.joins(:property)
          .where('spree_properties.name = ?', name)
          .first.try(:value)
      end
    end

  private

    def property_cache_key(property_name)
      "product-#{self.id}-property-#{property_name}"
    end

    def clear_property_cache
      properties.each do |property|
        Rails.cache.delete(property_cache_key(property.name))
      end
    end

  end
end