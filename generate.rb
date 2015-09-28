#!/usr/bin/env ruby
#email w.zongyu@gmail.com
#code to generate prime p and prime next to p

require 'openssl'

class Gen
  def initialize(bit)
    @p = OpenSSL::BN.generate_prime(bit.to_i)
    @q = nextprime
  end

  def nextprime #generate bn next prime
    q = @p.dup
    begin 
      q += 1
    end until q.prime?
    return q
  end

  def pnq
    return @p, @q
  end

  def pxq
    @p*@q
  end
end

p Gen.new(2048).pxq
