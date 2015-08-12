require 'benchmark/ips'

URL = 'http://www.thelongestlistofthelongeststuffatthelongestdomainnameatlonglast.com/wearejustdoingthistobestupidnowsincethiscangoonforeverandeverandeverbutitstilllookskindaneatinthebrowsereventhoughitsabigwasteoftimeandenergyandhasnorealpointbutwehadtodoitanyways.html'

# This code would actually be WRONG:
def slow
  URL.gsub('http://', 'https://')
end

# This code would actually be WRONG:
def fast
  URL.sub('http://', 'https://')
end

def correct_regex
  URL.sub(/^http:\/\//, 'https://')
end

def correct_manual
  return URL unless URL[0,7] == 'http://'
  u = URL.dup
  u[0,7] = 'https://'
  u
end

Benchmark.ips do |x|
  x.report('String#gsub') { slow }
  x.report('String#sub')  { fast }
  x.report('correct regex') { correct_regex }
  x.report('correct manual') { correct_manual }
  x.compare!
end
