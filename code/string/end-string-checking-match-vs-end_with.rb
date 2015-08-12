require 'benchmark/ips'

SLUG = 'root_url'
URL = 'url'
PATH = 'path'

def slow
  SLUG =~ /_(path|url)$/
end

def fast
  SLUG.end_with?('_path', '_url')
end

def nogroup
  SLUG =~ /_(?:path|url)$/
end

# Note: much faster when early exit branch taken :-P
def manual
  (SLUG[-4] == ?_ && SLUG[-3,3] == URL) ||
    (SLUG[-5] == ?_  && SLUG[-4,4] == PATH)
end

Benchmark.ips do |x|
  x.report('String#=~')        { slow }
  x.report('String#end_with?') { fast }
  x.report('String#=~ nogroup') { nogroup }
  x.report('manual') { manual }
  x.compare!
end
