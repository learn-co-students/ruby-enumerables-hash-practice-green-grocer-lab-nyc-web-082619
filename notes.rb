cart_test = {
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}

coupon_test = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]

p cart_test[coupon_test[0][:item]][:count]

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        coupon_item = cart["#{coupon[:item]} W/COUPON"]
        if cart[coupon_item]
          cart[coupon_item][:count] += coupon[:item][:num]
        else
          cart[coupon_item] = {
            price: coupon[:cost]/ coupon[:num],
            clearance: true,
            count: coupon[:num]
        }
        end
        cart[cart.keys[0]][:count] -= coupon[:num]
      end
    end
  end 
  cart
end

