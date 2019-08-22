def consolidate_cart(cart)
  new_cart = {}
  cart.each { |item|
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] += 1
    else 
      new_cart[item.keys[0]] = {
        :price => item.values[0][:price],
        :clearance => item.values[0][:clearance],
        :count => 1
      }
    end  
  }
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        coupon_item = "#{coupon[:item]} W/COUPON"
        if cart[coupon_item]
          cart[coupon_item][:count] += coupon[:num]
        else
          cart[coupon_item] = {
            :price => coupon[:cost]/coupon[:num],
            :clearance => cart[coupon[:item]][:clearance],
            :count => coupon[:num]
          }
          end
      cart[coupon[:item]][:count] -= coupon[:num]  
        end
      end
    end
cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.80).round(2)
    end  
  end  
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  total = 0
  clearance_cart.keys.each do |item|
    total += clearance_cart[item][:price] * clearance_cart[item][:count]
  end  
  if total > 100
    total *= 0.90
  end
    total
end
