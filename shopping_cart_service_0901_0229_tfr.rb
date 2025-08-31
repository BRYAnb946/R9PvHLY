# 代码生成时间: 2025-09-01 02:29:52
# shopping_cart_service.rb

# Shopping Cart Service using Ruby and CUBA framework
# This service manages the shopping cart functionality

class ShoppingCartService
  # Initializes a new shopping cart
  def initialize
    @cart = []
  end

  # Adds an item to the cart
  # @param item [Hash] The item to be added to the cart, with keys :id and :quantity
  def add_item(item)
    # Check if the item hash is valid
    unless item.is_a?(Hash) && item.has_key?(:id) && item.has_key?(:quantity)
      raise ArgumentError, 'Item must be a hash with :id and :quantity keys'
    end
    
    # Find the item in the cart or add a new one
    @cart.each do |cart_item|
      if cart_item[:id] == item[:id]
        cart_item[:quantity] += item[:quantity]
        return
      end
    end
    
    # Add the new item to the cart
    @cart << item
  end

  # Removes an item from the cart
  # @param item_id [Integer] The ID of the item to be removed
  def remove_item(item_id)
    # Find the item and remove it from the cart
    @cart.reject! { |item| item[:id] == item_id }
  end

  # Updates the quantity of an item in the cart
  # @param item_id [Integer] The ID of the item to be updated
  # @param quantity [Integer] The new quantity of the item
  def update_item_quantity(item_id, quantity)
    # Find the item and update its quantity
    cart_item = @cart.find { |item| item[:id] == item_id }
    if cart_item
      cart_item[:quantity] = quantity
    else
      raise ArgumentError, 'Item not found in the cart'
    end
  end

  # Returns the current state of the cart
  # @return [Array<Hash>] The items in the cart with their quantities
  def get_cart
    @cart
  end

  # Empties the cart
  def clear_cart
    @cart.clear
  end
end