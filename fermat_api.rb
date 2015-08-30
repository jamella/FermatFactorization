#!/usr/bin/env ruby
#REF: https://en.wikipedia.org/wiki/Fermat's_factorization_method

class SqrtInt
  #REF http://stackoverflow.com/questions/15529205/ruby-sqrt-on-a-very-large-integer-cause-rounding-issues
  def self.sqrt a
    begv = 1
    endv = a
    while endv > begv + 1
       mid = (endv + begv)/2
       if mid ** 2 <= a
          begv = mid
       else
          endv = mid
       end
    end
    return begv
  end

  def self.is_square a
    return Math.sqrt(a).ceil == Math.sqrt(a).floor
  end
end

class FermatExp
  def initialize(n)
    @N = n.to_i
    exit if sanitycheck == false
  end

  def sanitycheck
    if @N.even?
      puts "n should be odd"
      return false
    end
    return true
  end

  def exploit
    a = SqrtInt.sqrt(@N)+1
    b2 = a*a - @N

    until SqrtInt.is_square(b2)
      a += 1
      b2 = a*a - @N
    end
    p = (a - SqrtInt.sqrt(b2)
    q = (a + SqrtInt.sqrt(b2)
    return  p,q if p*q==@N
  end
end

