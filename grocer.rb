require "pry"

def consolidate_cart(cart)
  newcart = {}
  cart.each do |food|
    #binding.pry
    if !newcart.has_key?(food.keys[0])
       food.each do |name, hash|
       #binding.pry
       newcart[name] = hash
        newcart[name][:count] = 1
      end
    else
        newcart[food.keys[0]][:count] += 1
  end
  end 
  newcart
end

def apply_coupons(cart, coupons)
  coupons.each do |coup|
    food = coup[:item]
    if cart.has_key?(food)
      if cart[food][:count] >= coup[:num]
          unless  cart["#{food} W/COUPON"].nil?
      cart["#{food} W/COUPON"][:count] += coup[:num]
    end
      cart["#{food} W/COUPON"] ||= {}
      cart["#{food} W/COUPON"][:price] ||= coup[:cost] / coup[:num]
      cart["#{food} W/COUPON"][:clearance] ||= cart[food][:clearance]
      cart["#{food} W/COUPON"][:count] ||= coup[:num]
      cart[food][:count] -= coup[:num]   
  
    end
  end
end
  cart
end

def apply_clearance(cart)
  cart.each do |item, hash|
    if hash[:clearance] == true
      hash[:price] = (hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  newcart = consolidate_cart(cart)
  withcoupons = apply_coupons(newcart, coupons)
  withclearance = apply_clearance(withcoupons)
  
  withclearance.each do |food, hash|
    total += (hash[:price] * hash[:count])
  end
  
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
