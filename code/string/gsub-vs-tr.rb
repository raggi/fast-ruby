require 'benchmark/ips'

SLUG = 'writing-fast-ruby'

def slow
  SLUG.gsub('-', ' ')
end

def fast
  SLUG.tr('-', ' ')
end

def gsubregex
  SLUG.gsub(/-/, ' ')
end

Benchmark.ips do |x|
  x.report('String#gsub') { slow }
  x.report('String#tr')   { fast }
  x.report('String#gsub(regex)')   { gsubregex }
  x.compare!
end
