require 'benchmark/ips'

ARRAY = (1..100).to_a

def slow_flatten_1
  ARRAY.map { |e| [e, e] }.flatten(1)
end

def slow_flatten
  ARRAY.map { |e| [e, e] }.flatten
end

def fast
  ARRAY.flat_map { |e| [e, e] }
end

# And we're ignoring allocations again and using inject dispatch hacks to get
# within a standard deviation of the fastest results... are you learning where
# ruby's performance is a problem yet?
def zipper
  ARRAY.zip(ARRAY).inject(:concat)
end

Benchmark.ips do |x|
  x.report('Array#map.flatten(1)') { slow_flatten_1 }
  x.report('Array#map.flatten')    { slow_flatten   }
  x.report('Array#flat_map')       { fast           }
  x.report('zipper') { zipper }
  x.compare!
end
