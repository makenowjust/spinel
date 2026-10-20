# A String method answering its slot's shared String, handed to a boxed
# parameter beside a later argument: the argument runs first into a temp
# of the handle, which the boxed parameter takes as it is.
class Offense
  attr_reader :cop_name, :message
  def initialize(cop_name, message)
    @cop_name = cop_name
    @message = message
  end
end
class Base
  def self.cop_name
    parts = name.split("::")
    "#{parts[-2]}/#{parts[-1]}"
  end
  def cop_name
    @cop_name ||= self.class.cop_name
  end
  def add_offense(msg)
    @offenses ||= []
    @offenses << Offense.new(cop_name, msg)
    nil
  end
  def offenses = @offenses
end
module Style
  class Foo < Base
  end
end
o = Style::Foo.new
o.add_offense("m")
b = +"buf"
other = Offense.new(b, "n")
other.cop_name << "!"
p o.offenses[0].cop_name, other.cop_name, b
