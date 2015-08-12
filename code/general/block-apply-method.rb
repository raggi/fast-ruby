require "benchmark/ips"

ARR = (1..100).to_a

def do_something(n)
  4*n + 2
end

def fast
  ARR.map { |n| do_something(n) }
end

def slow
  ARR.map(&method(:do_something))
end

PREBOUND = method(:do_something).to_proc

def prebound
  ARR.map(&PREBOUND)
end

Benchmark.ips do |x|
  x.report("normal")  { fast }
  x.report("&method") { slow }
  x.report("prebound") { prebound }
  x.compare!
end
