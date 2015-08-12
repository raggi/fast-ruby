require 'benchmark/ips'

ARRAY = [*1..100]

def slow
  ARRAY.each_with_index do |number, index|
    number + index
  end
end

def fast
  index = 0
  while index < ARRAY.size
    ARRAY[index] + index
    index += 1
  end
end

def faster
  index = 0
  # The other common trick here is to do the work in reverse and countdown to 0
  size = ARRAY.size
  while index < size
    ARRAY[index] + index
    index += 1
  end
end

def ranger
  (0...ARRAY.size).each do |index|
    ARRAY[index] + index
  end
end

Benchmark.ips do |x|
  x.report('each_with_index') { slow  }
  x.report('While Loop')      { fast  }
  x.report('faster')      { faster  }
  x.report('ranger')      { ranger  }
  x.compare!
end
