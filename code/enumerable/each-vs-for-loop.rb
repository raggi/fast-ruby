require 'benchmark/ips'

ARRAY = [*1..100]

def slow
  for number in ARRAY do
    number
  end
end

def fast
  ARRAY.each do |number|
    number
  end
end

# This will fuck up your world view:
def alternative_rock
  a = ARRAY.dup
  while number = a.shift
    number
  end
end

Benchmark.ips do |x|
  x.report('For loop') { slow  }
  x.report('#each')    { fast  }
  x.report('alternative_rock')    { alternative_rock  }
  x.compare!
end
