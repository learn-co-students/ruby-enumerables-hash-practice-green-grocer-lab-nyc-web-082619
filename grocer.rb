def consolidate_cart(cart)
  new_cart = { }
  
  cart.each do |items| 
    items.each do |item, info|
      new_cart[item] = info 
      # info is inner hash of the item:{:price => 3.00, :clearance => true }
      if new_cart[item][:count]
        new_cart[item][:count] += 1
      else
        new_cart[item][:count] = 1
      end
    end
  end
  
  return new_cart
end


def apply_coupons(cart, coupons)
  
  coupons.each do |coupon|
    coupon.each do |item, info|
      food_name = coupon[:item]
      
      if cart[food_name] && cart[food_name][:count] >= coupon[:num]
        
        if cart["#{food_name} W/COUPON"]
          cart["#{food_name} W/COUPON"][:count] += coupon[:num]
        else
          cart["#{food_name} W/COUPON"] = {
            :price => coupon[:cost]/coupon[:num], 
            :clearance => cart[food_name][:clearance], 
            :count => coupon[:num]}
        end
        
        cart[food_name][:count] -= coupon[:num]
      end
      
    end
  end
  
  cart
end


def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.80).round(2)
    end
   end 
   
   cart
end


def checkout(cart, coupons)
  total = 0
  consolidated = consolidate_cart(cart)
  coupon_applied = apply_coupons(consolidated, coupons)
  clearance = apply_clearance(coupon_applied)
  
  clearance.each do |item, info|
    total += info[:price] * info[:count]
  end
  
  if total > 100
    total = total * 0.9
  end
  
  total
end
