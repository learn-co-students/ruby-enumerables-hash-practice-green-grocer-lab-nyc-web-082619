def consolidate_cart(cart)
  counted_cart = {}
  cart.each do |item| 
    item.each do |k,v|
      if counted_cart[k].nil? 
        counted_cart[k] = v.merge({:count => 1}) 
      else   
        counted_cart[k][:count] += 1 
      end
    end
  end
  counted_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon.each do |attribute, value|
      name = coupon[:item]
      
      if cart[name] && cart[name][:count] >= coupon[:num]
        if cart["#{name} W/COUPON"]
          cart["#{name} W/COUPON"][:count] += coupon[:num] 
        else 
          cart["#{name} W/COUPON"] = {:price => (coupon[:cost]/coupon[:num]), :clearance => cart[name][:clearance], :count => coupon[:num]}
        end
      cart[name][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, attribute_hash|
    if attribute_hash[:clearance] == true 
      attribute_hash[:price] = (attribute_hash[:price] * 0.8).round(2) 
    end
  end
  cart
end

def checkout(cart, coupons)
  #apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
  total = 0 
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  clearance_cart.each do |item, attribute_hash|
    total += (attribute_hash[:price] * attribute_hash[:count])
  end 
  
  total = (total * 0.9) if total > 100 
  
  total 
end
