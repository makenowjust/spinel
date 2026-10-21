# An each over the new String Array split answers, whose block hands each
# element to a method that appends to it, is the last statement of a branch
# of a statement whose value nobody reads: an if, an unless with an else, a
# case, a plain begin and a begin with a rescue, all inside a while body.
# The each's answer is thrown away as the branch's, so each element is seen
# only through the block and the appends change no other name's String.
class Collector
  def initialize
    @out = []
  end

  attr_reader :out

  def add(t)
    t << "!"
    @out << t
  end

  def run(text, kind)
    i = 0
    while i < 2
      if i > 0
        text.split(",").each { |part| add(part) }
      end
      unless kind == :b
        text.split(",").each { |part| add(part) }
      else
        text.split(";").each { |part| add(part) }
      end
      case kind
      when :a then text.split(",").each { |part| add(part) }
      else text.split("b").each { |part| add(part) }
      end
      begin
        text.split(",").each { |part| add(part) }
      end
      begin
        text.split(",").each { |part| add(part) }
      rescue ArgumentError
        text.split(";").each { |part| add(part) }
      end
      i += 1
    end
    nil
  end
end

c = Collector.new
text = +"a,b"
c.run(text, :a)
p c.out
p text
d = Collector.new
d.run(text, :b)
p d.out.size
p d.out.first(4)
p text
