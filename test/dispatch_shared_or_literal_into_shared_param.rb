# A call whose targets answer a slot's shared String or a String literal,
# handed on as a method's argument, hands on the object: the literal keeps
# one identity, and the shared String is the one its slot holds.
def keep(t)
  t << "!" unless t.frozen?
  t
end
class J; def zork = "j"; end
class K
  def initialize = @b = +"buf"
  def zork = @b
end
[K.new, J.new].reverse.each { |v| p keep(v.zork) }

class Offense
  attr_reader :cop_name
  def initialize(cop_name) = @cop_name = cop_name
end
class Base
  def cop_name
    @cop_name ||= self.class.name
  end
  def add_offense
    @offenses ||= []
    @offenses << Offense.new(cop_name)
    nil
  end
  def offenses = @offenses
end
class Dept < Base
  def cop_name = "Migration/DepartmentName"
end
bs = Base.new
d = Dept.new
[bs, d].each { |o| o.add_offense; o.add_offense }
other = Offense.new(+"buf")
other.cop_name << "!"
p bs.offenses.map(&:cop_name), d.offenses.map(&:cop_name)
p bs.offenses[0].cop_name.equal?(bs.offenses[1].cop_name), d.offenses[0].cop_name.equal?(d.offenses[1].cop_name)
p other.cop_name
