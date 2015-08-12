require 'benchmark/ips'

FOO = "foo".freeze
BOO = /boo/

def fast
  FOO =~ BOO
end

def slow
  FOO.match(BOO)
end

Benchmark.ips do |x|
  x.report("String#=~") { fast }
  x.report("String#match") { slow }
  x.compare!
end
