def consolidate_cart(cart)
  new_cart = {}
  item_count = :count
    cart.each do |item_hash|
      item_hash.each do |item_name, details|
        if new_cart.include?(item_name) == false
          new_cart[item_name] = details
          new_cart[item_name][item_count] = 1
        else new_cart.include?(item_name) == true
          new_cart[item_name][:count] += 1
        end
      end
    end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        coupon_item = "#{coupon[:item]} W/COUPON"
          if cart[coupon_item]
            cart[coupon_item][:count] += coupon[:num]
          else
            cart[coupon_item] = {
              price: coupon[:cost] / coupon[:num],
              clearance: cart[coupon[:item]][:clearance],
              count: coupon[:num]
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
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
cart = consolidate_cart(cart)
discount_cart = apply_coupons(cart, coupons)
final_cart = apply_clearance(discount_cart)

total = 0

 final_cart.each do |item, value|
  total += value[:price] * value[:count]
end

 if total > 100.0 == true
  total = (total * 0.90).round(2)
end
total
end