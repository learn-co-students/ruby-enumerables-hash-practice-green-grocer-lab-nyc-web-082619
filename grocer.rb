def consolidate_cart(cart)
consolidated_cart = {}
cart.each do |item|
  if consolidated_cart[item.keys[0]]
    consolidated_cart[item.keys[0]][:count] += 1
  else
   consolidated_cart[item.keys[0]] = {
      count: 1,
      price: item.values[0][:price],
      clearance: item.values[0][:clearance]
    }
end
end
p consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        coup = "#{coupon[:item]} W/COUPON"
        if cart[coup]
          cart[coup][:count] += coupon[:num]
        else
          cart[coup] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
            }
          end
          p cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
    p cart
  end
  
  


def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end
  end
  p cart
end

def checkout(cart, coupons)
  
  checkout_cart = consolidate_cart(cart)
  checkout_w_coups = apply_coupons(checkout_cart, coupons)
  checkout_w_discounts = apply_clearance(checkout_w_coups)
  
  total = 0.0
  
  checkout_w_discounts.keys.each do |item|
    total += checkout_w_discounts[item][:price] * checkout_w_discounts[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end
