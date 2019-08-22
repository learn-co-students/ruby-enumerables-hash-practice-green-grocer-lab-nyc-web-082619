require "pry"

def consolidate_cart(cart)
  new_cart_hash = {}
  cart.each do |groceries| 
    groceries.each do |item, attributes|
    if new_cart_hash[item]
      new_cart_hash[item][:count] += 1 
    else 
      new_cart_hash[item] = attributes
      new_cart_hash[item][:count] = 1 
     end
   end
  end
  new_cart_hash
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_name = coupon[:item]
    if cart.has_key?(coupon_name)
      if cart[coupon_name][:count] >= coupon[:num]
        if cart["#{coupon[:item]} W/COUPON"]
          cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
        else
          cart["#{coupon[:item]} W/COUPON"] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon_name][:clearance]
          }
        end
        cart[coupon_name][:count] -= coupon[:num]
      end
    end
  end
  cart
end




def apply_clearance(cart)
  cart.each do |item, attribute|
    if attribute[:clearance] == true 
      attribute[:price] = (attribute[:price] *
      0.8).round(2) 
    end 
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  w_coupons = apply_coupons(new_cart, coupons)
  w_clearance = apply_clearance(w_coupons)
  
  final_cost = 0 
  w_clearance.each do |item, attribute|
    final_cost += (attribute[:price] * attribute[:count])
  end
  final_cost = (final_cost * 0.9) if final_cost > 100
  return final_cost
end

