require 'benchmark/ips'

SLUG = 'test_reverse_merge.rb'

def slow
  SLUG =~ /^test_/
end

def fast
  SLUG.start_with?('test_')
end

def manual_strnew4
  SLUG[0,5] == 'test_'
end

def manual_fast_exit
  SLUG[0] == ?t &&
    SLUG[1] == ?e &&
    SLUG[2] == ?s &&
    SLUG[3] == ?t &&
    SLUG[4] == ?_
end

Benchmark.ips do |x|
  x.report('String#=~')          { slow }
  x.report('String#start_with?') { fast }
  x.report('manual_strnew4') { manual_strnew4 }
  x.report('manual_fast_exit') { manual_fast_exit }
  x.compare!
end
