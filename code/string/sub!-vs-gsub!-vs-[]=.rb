require "benchmark/ips"

URL = "http://www.thelongestlistofthelongeststuffatthelongestdomainnameatlonglast.com/wearejustdoingthistobestupidnowsincethiscangoonforeverandeverandeverbutitstilllookskindaneatinthebrowsereventhoughitsabigwasteoftimeandenergyandhasnorealpointbutwehadtodoitanyways.html"

def fast
  s = URL.dup
  s["http://"] = ""
end

def slow_1
  s = URL.dup
  s.sub! "http://", ""
end

def slow_2
  s = URL.dup
  s.gsub! "http://", ""
end

def slow_3
  s = URL.dup
  s[%r{http://}] = ""
end

def slow_4
  s = URL.dup
  s.sub! %r{http://}, ""
end

def slow_5
  s = URL.dup
  s.gsub! %r{http://}, ""
end

# correct because we only want to sub the start.
# doesn't waste time looking at the rest of the string
# doesn't allocate until it's time to do so
# utilizes string COW to reduce allocations.
def correct_fast
  return URL.dup if URL[0,7] != 'http://'
  URL[7,URL.length]
end

Benchmark.ips do |x|
  x.report("String#['string']=")   { fast   }
  x.report("String#sub!'string'")  { slow_1 }
  x.report("String#gsub!'string'") { slow_2 }
  x.report("String#[/regexp/]=")   { slow_3 }
  x.report("String#sub!/regexp/")  { slow_4 }
  x.report("String#gsub!/regexp/") { slow_5 }
  x.report("correct fast") { correct_fast }
  x.compare!
end
