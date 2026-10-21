# `join` without arguments on a boxed receiver that may be an Array or an
# object of a class defining its own `join`: the Array's arm joins into a
# new String, and so does each class's method here (one takes a block,
# so it is reached through its proc form). The answer is written to a
# local and kept in a list whose Strings are appended to afterwards: no
# other String changes.
class Pair
  def initialize(*xs) = @items = xs
  def join(*args, &block) = @items.join(*args, &block)
end

class Triple
  def initialize(*xs) = @items = xs
  def join(*args) = @items.join(*args)
end

class Shelf
  def initialize = @all = []
  attr_reader :all
  def put(t) = @all << t
end

shelf = Shelf.new
[["a", "b"], Pair.new("c", "d"), Triple.new("e", "f", "g")].each do |x|
  text = x.join
  shelf.put(text)
end
shelf.all[0] << "!"
shelf.all[1] << "?"
shelf.all[2] << "."
p shelf.all
