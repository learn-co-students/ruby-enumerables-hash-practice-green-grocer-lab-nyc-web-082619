def consolidate_cart(cart)
  hash = {}
  cart.each |item}{
    if hash.key?(item)
      hask[item][:count] +=1
    else
      hash[item] = {:price => each[:price], :clearance => each[:clearance], count => 1}
  }
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
