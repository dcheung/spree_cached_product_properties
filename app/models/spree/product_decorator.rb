module Spree
  Product.class_eval do

    def property(name)
      Rails.cache.fetch(property_cache_key(name)) do
        product_properties.joins(:property)
          .where('spree_properties.name = ?', name)
          .first.try(:value)
      end
    end

    def property_cache_key(property_name)
      "product-#{self.id}-property-#{property_name}"
    end

  end
end