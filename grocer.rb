require 'pry'
def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |items|
    items.each do |key1, value1|
      if consolidated_cart.has_key? key1
        consolidated_cart[key1][:count] += 1
      else
        consolidated_cart[key1] = value1
        consolidated_cart[key1][:count] = 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.has_key? coupon[:item]
      if cart.has_key?(coupon[:item] + " W/COUPON")
        cart[coupon[:item] + " W/COUPON"][:count] += 1
      else
        cart[coupon[:item] + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
      end
      cart[coupon[:item]][:count] -= coupon[:num]  
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance]
      value[:price] = value[:price] - (value[:price] * 0.2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  #binding.pry
  #cart = apply_coupons(cart, coupons)
  #cart = apply_clearance(cart)
  
  sub_total = 0
  cart.each do |key1, value1|
    sub_total += value1[:price]
  end
  sub_total
end
