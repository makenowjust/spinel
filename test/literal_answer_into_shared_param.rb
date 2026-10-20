# A method answering a String literal hands on the literal itself, which
# keeps one identity: into a parameter whose String is shared with
# another name and changed in place, through a dispatch beside a method
# answering a shared slot, and from a base class whose subclass alone
# defines the method.
class Offense
  attr_reader :cop_name, :message
  def initialize(cop_name, message)
    @cop_name = cop_name
    @message = message
  end
end
class Base
  def cop_name
    @cop_name ||= self.class.name
  end
  def add_offense(msg)
    @offenses ||= []
    @offenses << Offense.new(cop_name, msg)
    nil
  end
  def offenses = @offenses
end
class Dept < Base
  def cop_name
    "Migration/DepartmentName"
  end
end
o = Dept.new
o.add_offense("m")
o.add_offense("n")
b = +"buf"
other = Offense.new(b, "x")
other.cop_name << "!"
a, z = o.offenses
p a.cop_name, z.cop_name, a.cop_name.equal?(z.cop_name), other.cop_name, b

class Offense2
  attr_reader :cop_name, :message
  def initialize(cop_name, message)
    @cop_name = cop_name
    @message = message
  end
end
class Base2
  def add_offense(msg)
    @offenses ||= []
    @offenses << Offense2.new(cop_name, msg)
    nil
  end
  def offenses = @offenses
end
class Dept2 < Base2
  def cop_name
    "Migration/DepartmentName"
  end
end
o = Dept2.new
o.add_offense("m")
o.add_offense("n")
b = +"buf"
other = Offense2.new(b, "x")
other.cop_name << "!"
a, z = o.offenses
p a.cop_name, z.cop_name, a.cop_name.equal?(z.cop_name), a.cop_name.frozen?, other.cop_name, b

# A base class no instance of which is made: its own cop_name is never
# what the call answers.
class Base3
  def cop_name
    @cop_name ||= self.class.name
  end

  def add_offense(msg)
    @offenses ||= []
    @offenses << Offense2.new(cop_name, msg)
    nil
  end

  def offenses = @offenses
end

class Dept3 < Base3
  def cop_name
    "Lint/Thing"
  end
end

d3 = Dept3.new
d3.add_offense("p")
d3.add_offense("q")
e, f = d3.offenses
p e.cop_name, e.cop_name.equal?(f.cop_name)
