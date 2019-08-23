require "pry"
def checkout(cart, coupons = [])
 total = 0
 carthash = Hash.new

if item == "AVOCADO"
         binding.pry
       end

# Consolidate cart

def consolidate_cart(cart)
  countarray = cart.each do |hash|
    hash[hash.keys.first][:count] = cart.count(hash)
  end
  countarray.each do |item|
    carthash[item.keys.first] = item.values.first
  end
  carthash
end

# Coupons
def apply_coupons(cart, coupons)
  i = 0
  carthash.each_key do |item|
    if coupons[0]
        if coupons[i][:item] == item
          oldnum = carthash[item][:count].clone
          coupon_cart["#{item} W/COUPON"] = {}
          coupon_cart[item][:count] = (carthash[item][:count] % coupons[i][:num])
          coupon_cart["#{item} W/COUPON"][:price] = (coupons[i][:cost] / coupons[i][:num])
          coupon_cart["#{item} W/COUPON"][:clearance] = carthash[item][:clearance]
          coupon_cart["#{item} W/COUPON"][:count] = (oldnum - coupon_cart[item][:count])
          i =+ 1
        else i =+ 1
      end
    end
  end
  coupon_cart
end
  
# Clearance
  def apply_clearance(cart)
    clearance_cart.each_key do |item|
    oldprice = coupon_cart[item][:price]
    if clearance_cart[item][:clearance]
      clearance_cart[item][:price] = oldprice - (oldprice / 5)
    end
    clearance_cart
  end

# Checkout

consolidate_cart(cart)
coupon_cart = carthash.clone
apply_coupons(carthash)
clearance_cart = coupon_cart.clone
apply_clearance(coupon_cart)


clearance_cart.each_key do |item|
    total =+ clearance_cart[item][:price]
  end
  puts total
end
end

checkout([
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
])