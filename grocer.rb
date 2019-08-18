def consolidate_cart(cart)
  counts = {}
  cart.each do |items|
    items.each do |item, info|
      counts[item] = info 
      if counts[item][:count] 
        counts[item][:count]+= 1 
      else
        counts[item][:count] = 1 
      end 
    end
  end
  counts
end

def apply_coupons(cart, coupons) 
  
  coupons.each do |coupon| 
    coupon.each do |item_name, info| 
      food = coupon[:item] 
    
      while cart[food] && cart[food][:count] >= coupon[:num] 
      count = cart["#{food} W/COUPON"] ? cart["#{food} W/COUPON"][:count] : 0 
          cart["#{food} W/COUPON"] = {:price => (coupon[:cost] / coupon[:num]) ,
          :clearance => cart[food][:clearance], :count => coupon[:num] + count }
      cart[food][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
end

def apply_clearance(cart)
  cart.each do |food, info|
    if info[:clearance] == true 
      info[:price] = (info[:price] * 0.80).round(2)
    end 
  end
   cart
end

def checkout(cart, coupons)
   total = 0 
  new_cart = consolidate_cart(cart)
  coups_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coups_cart)
    
    clearance_cart.each do |food, info|
      total += (info[:count] * info[:price])
    end 
    total > 100 ? total * 0.9 : total 
end
