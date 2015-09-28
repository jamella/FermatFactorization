#!/usr/bin/env ruby
#REF: https://en.wikipedia.org/wiki/Fermat's_factorization_method

require 'optparse'

class ARGVParser
  def initialize
    @@options = {}
    @banner = "Usage fermat.rb [options]"
    OptionParser.new do |opts|
      opts.banner = @banner

      opts.on("-n N", "Value to factor") do |v|
        options[:n] = v
      end

    end.parse!
    exit if sanitycheck == false
  end

  def sanitycheck
    if @@options[:n].nil?
      puts "#{@banner} #-h for help"
      return false
    end
  end

  def options
    @@options
  end
end

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
    return a == (SqrtInt.sqrt(a) ** 2)
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
    p = (a - SqrtInt.sqrt(b2))
    q = (a + SqrtInt.sqrt(b2))
    return p,q if @N == p*q
  end
end

opts = ARGVParser.new.options
p, q = FermatExp.new(opts[:n].to_i).exploit

puts "p = #{p}"
puts "q = #{q}"
