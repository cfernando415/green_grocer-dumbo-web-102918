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
      if cart.has_key?(coupon[:item] + " W/COUPON") && coupon[:num] <= cart[coupon[:item]][:count]
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
  
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  #binding.pry
  clearance_applied = apply_clearance(coupons_applied)
  
  sub_total = 0
  clearance_applied.each do |key, value|
    sub_total += value[:price] * value[:count]
  end
  if sub_total > 100
    sub_total = (sub_total * 0.9)
  end
  sub_total
end
