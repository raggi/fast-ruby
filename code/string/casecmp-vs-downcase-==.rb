require 'benchmark/ips'

SLUG = 'ABCD'
Slug = 'abcd'

def slow
  SLUG.downcase == Slug
end

def fast
  SLUG.casecmp(Slug) == 0
end

Benchmark.ips do |x|
  x.report('String#downcase + ==') { slow }
  x.report('String#casecmp')       { fast }
  x.compare!
end
