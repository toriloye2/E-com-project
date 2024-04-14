require 'net/http'
require 'json'
require 'faker'

# Define the method to fetch product data from the API
require 'net/http'
require 'json'

# Define the method to fetch game data from the API
def fetch_games_from_api(format, api_key)
  uri = URI("https://api.mobygames.com/v1/games?format=#{format}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri)
  request['Authorization'] = "Bearer #{api_key}"

  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  else
    puts "Error fetching game data: #{response.code} - #{response.message}"
    nil
  end
end



# Fetch games in the desired format
games_data = fetch_games_from_api('normal')

# Process the game data as needed
games_data['games'].each do |game|
  # Access game attributes here and do whatever you need with them
  puts game['title']
  puts game['description']
  # Add more attributes as needed
end



puts "Products Creation from API ..."
data = fetch_products_from_api


data.each do |product_data|
  puts product_data.inspect  # Add this line for debugging
  Product.create!(
    name: product_data['name'],       # Accessing the 'name' attribute
    description: product_data['summary'],  # Accessing the 'summary' attribute
    price: product_data['price']      # Accessing the 'price' attribute
    # Add more attributes as needed
  )
end


# Seed the database with admin user only if it doesn't already exist
unless AdminUser.exists?(email: 'admin@admin.com')
  AdminUser.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
end

# Seed the database with product categories
puts "Game Categories Creation ..."
cat1 = ProductCategory.find_or_create_by!(name: 'Game Products')
# Define other categories as needed

# Seed the database with additional products
puts "Additional Products Creation ..."
# Add your existing product seeding logic here
