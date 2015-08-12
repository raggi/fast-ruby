require 'benchmark/ips'

METHODNAMES = 10.times.map do
  10.times.inject("") { |e| e << ('a'..'z').to_a.sample}
end

class Class
  public :define_method
  public :module_eval
end

def def_methods(klass, _methods)
  _methods.each do |method_name|
    klass.define_method method_name do
      self
    end
  end
end

def mod_def_methods(klass, _methods)
  klass.module_eval(_methods.map do |method_name|
    %{
        def #{method_name}
          self
        end
    }
  end.inject(:concat))
end

def fast
  klass = Class.new
  def_methods(klass, METHODNAMES)
  METHODNAMES.inject(klass.new, :send)
end

def slow
  klass = Class.new
  mod_def_methods(klass, METHODNAMES)
  METHODNAMES.inject(klass.new, :send)
end


Benchmark.ips do |x|
  x.report("module_eval with string") { slow }
  x.report("define_method")           { fast }
  x.compare!
end
