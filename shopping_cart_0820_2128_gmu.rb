# 代码生成时间: 2025-08-20 21:28:44
#
# shopping_cart.rb
# Shopping Cart Implementation using RUBY and CUBA Framework
#

require 'cuba'
require 'cuba/plugin/flash'
require 'sinatra/flash'
require 'data_mapper'

# Define the Product model
class Product
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :price, Float
end

# Define the CartItem model
class CartItem
  include DataMapper::Resource

  property :id, Serial
  property :product_id, Integer
  property :quantity, Integer
end

# Define the Cart model
class Cart
  include DataMapper::Resource

  property :id, Serial
  property :session_id, String
end

# Setup CUBA
Cuba.plugin Cuba::Flash
Cuba.use Rack::Session::Cookie, :secret => 'my_secret'

# Initialize DataMapper
DataMapper.setup(:default, 'sqlite3:shopping_cart.db')
DataMapper.finalize.auto_migrate!

# Shopping Cart Application
Cuba.define do

  # Home route
  on get do
    res.write("Welcome to the Shopping Cart application.")
  end

  # Route to display the cart
  on get, 'cart' do
    cart = Cart.first(:session_id => session[:id]) || Cart.create(:session_id => session[:id])
    items = CartItem.all(:product_id => cart.id)
    res.write("Your cart contains: " + items.map(&:product).map(&:name).join(', '))
  end

  # Route to add a product to the cart
  on post, 'add_product' do
    product_id = params['product_id'].to_i
    quantity = params['quantity'].to_i
    if product_id <= 0 || quantity <= 0
      flash[:error] = 'Invalid product or quantity'
      redirect to('/cart')
    else
      product = Product.get(product_id)
      if product
        cart = Cart.first(:session_id => session[:id]) || Cart.create(:session_id => session[:id])
        cart_item = CartItem.all(:product_id => product.id, :cart_id => cart.id).first
        if cart_item
          cart_item.update(:quantity => cart_item.quantity + quantity)
        else
          CartItem.create(:product_id => product.id, :quantity => quantity, :cart_id => cart.id)
        end
        flash[:notice] = 'Product added to cart successfully'
      else
        flash[:error] = 'Product not found'
      end
      redirect to('/cart')
    end
  end

  # Route to remove a product from the cart
  on post, 'remove_product' do
    product_id = params['product_id'].to_i
    if product_id <= 0
      flash[:error] = 'Invalid product'
      redirect to('/cart')
    else
      cart = Cart.first(:session_id => session[:id])
      if cart
        cart_item = CartItem.all(:product_id => product_id, :cart_id => cart.id).first
        if cart_item
          cart_item.destroy
          flash[:notice] = 'Product removed from cart successfully'
        else
          flash[:error] = 'Product not found in cart'
        end
      else
        flash[:error] = 'Cart not found'
      end
      redirect to('/cart')
    end
  end

end