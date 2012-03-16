module OrdersHelper
  def restaurants( order )
    restaurants = order.items.map { |item| item.restaurant.try(:name) }.compact.uniq
    if restaurants.present?
      restaurants.join(', ')
    else
      content_tag :em, "Unknown restaurant"
    end
  end
end
