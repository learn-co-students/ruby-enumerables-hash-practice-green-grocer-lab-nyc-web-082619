require 'pry'
def consolidate_cart(cart)
  new_cart = {} 
  cart.each do |hash|
    if new_cart.keys.include?(hash.keys[0]) 
      new_cart[hash.keys[0]][:count] +=1
    else 
    new_cart[hash.keys[0]] = hash[hash.keys[0]] #this adds price and clearence to new_cart
    new_cart[hash.keys[0]][:count] = 1 #this creates a new key called count in the new_cart and sets the value as 1
    end
  end
  return new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item] #if AVOCADO appears
      if cart[coupon[:item]][:count] >= coupon[:num] #minimum amount for it to apply
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name] #if it exists, add this
          cart[new_name][:count] += coupon[:num]
        else #else create it with that data
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |keys|
    if cart[keys][:clearance] 
      cart[keys][:price] -= ((cart[keys][:price]) * 0.2)
    end
  end
return cart
end



def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  new_cart = apply_coupons(consolidated, coupons)
  updated = apply_clearance(new_cart)

  next_updated = 
  updated.reduce(0) do |memo, (key, value)|
    memo += (value[:price] * value[:count])
  end   

  if next_updated > 100 
    next_updated -= (next_updated * 0.10)
    return next_updated
  else
    return next_updated
  end
  
end

