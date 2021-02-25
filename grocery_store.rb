# Basic Objectives
# Display a menu in the console for the user to interact with. X
# Create a default array of hashes that represent items at a grocery store. X
# Create a menu option to add items to a user's grocery cart. X
# Create a menu option to display all the items in the cart. X
# Create a menu option to remove an item from the users cart. X
# Create a menu option to show the total cost of all the items in the user's cart. X
# Add new items to the grocery store. 
# Zip it up and turn it in!

# Bonus Objectives:
# Allow a user to remove multiple items at once from the cart. X
# Assign the user an amount of money to start.
# Give the user the option to "Check out".
# If they have enough money, their cart gets cleared and money is subtracted.
# If they don't have enough money, they have to delete items.
# Apply some sort of coupon system.
# For example, a 20% off coupon that takes the price of all items down by 20%.
# Apply taxes to transaction.
# A menu option that shows a history of all the items purchased. (While the script runs)
# Grocery store items have a quantity. (They can be out of stock)

@options = [
  {key: 1, option: "Add items to your cart"},
  {key: 2, option: "Display items to your cart"},
  {key: 3, option: "Remove items in your cart"},
  {key: 4, option: "Show the total cost of your items"},
  {key: 5, option: "Exit"}
]

def display_menu
  puts "What would you like to do?"
  @options.each { |menu_item| puts "#{menu_item[:key]}) #{menu_item[:option]}"}
end

def display_options
  @groceries.each do
    |grocery| puts "#{grocery[:key]}) #{grocery[:item]}: $#{"%.2f" % grocery[:cost]}"
  end
end

def add_item
  basket = {}
  display_options
  puts "What item would you like to add to your cart?"
  selection = gets.chomp.to_i
  basket[:item] = @groceries[selection - 1][:item]
  basket[:cost] = @groceries[selection - 1][:cost]
  @my_cart << basket
  puts "You've added 1 #{basket[:item]} to your cart"
end

def display_cart
  puts "My Cart:"
  @my_cart.each_with_index { |cart_item, index| puts "#{index + 1}) #{cart_item[:item]}: $#{"%.2f" % cart_item[:cost]}"}
end

def remove_item
  continue = "yes"
  until continue == "no"
    display_cart
    puts "What item would you like to remove from your cart?"
    selection = gets.chomp.to_i
    @my_cart.delete_at(selection - 1)
    puts "Would you like to remove another item from your cart? (yes/no)"
    continue = gets.chomp.to_s.downcase
  end
end

def checkout
  total = 0
  display_cart
  puts "Do you have any coupon codes? (yes/no)"
  coupon_yes_no = gets.chomp.to_s
  if coupon_yes_no == "yes"
    puts "What is the coupon code? (coupon = DEVPOINT)"
    coupon = gets.chomp.to_s.upcase
    if coupon == "DEVPOINT"
      discount = 0.20
      @my_cart.each do |cart_item|
        total += cart_item[:cost]
      end
      discount_total = total * discount
      puts "Total Before Discount: $#{"%.2f" % total}"
      puts "Discount: $#{"%.2f" % discount_total}"
      total = total - (total * discount)
      puts "Total After Discount: $#{"%.2f" % total}"
    else
      puts "Coupon code doesn't exist! Try again"
    end
  else
    @my_cart.each do |cart_item|
      total += cart_item[:cost]
    end
    puts "Your total is $#{"%.2f" % total}"
  end
end

@groceries = [
  {key: 1, item: "apple", cost: 2.00},
  {key: 2, item: "orange", cost: 3.00},
  {key: 3, item: "banana", cost: 1.50}
]

@my_cart = []

choice = 1
until choice == 5
  puts "---------------------------"
  display_menu
  choice = gets.chomp.to_i
  case choice
    when 1
      add_item
    when 2
      display_cart
    when 3
      remove_item
    when 4
      checkout
    when 5
      exit 
    else
      puts "That is not an option: try again"
  end
end
