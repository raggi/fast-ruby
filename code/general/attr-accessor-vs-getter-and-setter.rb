require 'benchmark/ips'

class User < Struct.new(:username)
  attr_accessor :first_name

  def last_name
    @last_name
  end

  def last_name=(value)
    @last_name = value
  end

end

def slow
  user = User.new
  user.last_name = 'John'
  user.last_name
end

def fast
  user = User.new
  user.first_name = 'John'
  user.first_name
end

def faster
  user = User.new
  user.username = 'John'
  user.username
end

Benchmark.ips do |x|
  x.report('getter_and_setter') { slow }
  x.report('attr_accessor')     { fast }
  x.report('struct field')     { faster }
  x.compare!
end
