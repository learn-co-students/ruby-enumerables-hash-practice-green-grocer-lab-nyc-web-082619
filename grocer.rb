def consolidate_cart(cart)
  consolidated_cart = {}
  for item in cart do
    item_key = item.keys[0]
	item_values = item.values[0]
	if (!consolidated_cart[item_key])
      item_values[:count] = 1
	  consolidated_cart[item_key] = item_values
  	else
	  consolidated_cart[item_key][:count] += 1
  	end
  end
  return consolidated_cart
end


def apply_coupons(cart, coupons)
  coupon_cart = cart
  for coupon in coupons do
    coupon_key = coupon[:item]
	
	  if(!coupon_cart[coupon_key])
	    break
  	end
	
    if(coupon_cart[coupon_key][:count] >= coupon[:num])
	    unit_discount_price = (coupon[:cost] / coupon[:num]).round(2)
      unit_on_clearance = coupon_cart[coupon_key][:clearance]
      unit_count = coupon[:num]
        
      coupon_cart[coupon_key][:count] -= coupon[:num]
       
      if(!coupon_cart["#{coupon_key} W/COUPON"])
        coupon_cart["#{coupon_key} W/COUPON"]= {
	      price: unit_discount_price,
        clearance: unit_on_clearance,
	      count: unit_count}
	    else
	      coupon_cart["#{coupon_key} W/COUPON"][:count] += unit_count
	    end 
    end
  end
  
  return coupon_cart
end

def apply_clearance(cart)
  cart.each do |key, value|
    if cart[key][:clearance]
      cart[key][:price] = (0.8 * cart[key][:price]).round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  sum = 0
  cart.each do |key, value|
    sum += (cart[key][:price] * cart[key][:count])
  end
  
  sum >= 100 ? sum = 0.9*sum : nil
  
  return sum
end