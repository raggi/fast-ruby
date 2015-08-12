require 'benchmark/ips'

ARRAY = (1..100).to_a

def slow
  array = []
  ARRAY.each { |i| array.push i }
end

def fast
  ARRAY.map { |i| i }
end

def prealloc_each
  array = Array.new(ARRAY.size)
  n = -1
  ARRAY.each { |i| array[n+=1] = i }
end

def prealloc_each_with_index
  array = Array.new(ARRAY.size)
  ARRAY.each_with_index { |i,n| array[n] = i }
end

def inject_dispatch_hacks
  # If this could pre-allocate it'd be as fast as map
  # It'd be nice if Enumerable supported the non-proc forms, ne?
  ARRAY.inject([], :push)
end

Benchmark.ips do |x|
  x.report('Array#each + push') { slow }
  x.report('Array#map')         { fast }
  x.report('prealloc_each') { prealloc_each }
  x.report('prealloc_each_with_index') { prealloc_each_with_index }
  x.report('inject_dispatch_hacks') { inject_dispatch_hacks }
  x.compare!
end
