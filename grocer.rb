def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name 
      return collection[i]
    end
    i += 1 
  end
end

def find_item_index_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name 
      return i 
    end
    i += 1 
  end
end

def add_count_to_item(hash)
  hash[:count] = 1 
  hash 
end 

def increment_count(hash)
  # didn't use this method 
  item_increment = hash[:count] += 1 
  item_increment
end

def consolidate_cart(cart)
  cart_with_item_count = []
  i = 0 
  while i < cart.length do 
    item_name = cart[i][:item]
    if !find_item_by_name_in_collection(item_name, cart_with_item_count)
      cart_with_item_count << add_count_to_item(cart[i])
    else 
      cart_with_item_count[find_item_index_in_collection(item_name, cart_with_item_count)][:count] += 1 
    end 
    i += 1 
  end 
  cart_with_item_count
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length do 
    if find_item_by_name_in_collection(coupons[i][:item], cart)[:count] >= coupons[i][:num]
      item_remainder = find_item_by_name_in_collection(coupons[i][:item], cart)[:count].remainder(coupons[i][:num])
      cart << {:item => "#{coupons[i][:item]} W/COUPON", :price => coupons[i][:cost]/coupons[i][:num], :clearance => cart[find_item_index_in_collection(coupons[i][:item], cart)][:clearance], :count => find_item_by_name_in_collection(coupons[i][:item], cart)[:count] - item_remainder}
      cart[find_item_index_in_collection(coupons[i][:item], cart)][:count] = item_remainder
    end
    i += 1 
  end 
  cart 
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = cart[i][:price]*0.80
    end 
    i += 1 
  end 
  cart 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  total = 0 
  i = 0 
  new_cart = consolidate_cart(cart)
  while i < new_cart.length do 
    if !new_cart[i][:item] == find_item_by_name_in_collection(new_cart[i][:item], coupons)[:item] && !new_cart[i][:clearance]
      total += new_cart[i][:price]*new_cart[i][:count]
    end 
  end 
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
