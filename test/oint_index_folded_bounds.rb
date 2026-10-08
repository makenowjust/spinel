# An index that can be nil folds its nil into the bounds compare: in range
# it reads or writes the element; a negative index, one past the end, an
# array with a nil in it and a nil index take the full read or write, which
# counts from the end, answers nil past it, keeps a nil element nil, and
# raises TypeError for the nil index.

def idx(k) = [k][ARGV.size]
def miss = [1][ARGV.size + 4]

def bump(a, map, base)
  r = 0
  out = []
  while r < 4
    i = map[base + r]
    a[i] = a[i] + 1 if i && i < a.size && a[i]
    out << (a[i] == 1 ? :one : a[i])
    r += 1
  end
  out
end

a = [0, 0, 0, 0]
map = [0, 1, 9, -1, 2, 3, 0, 1]
p bump(a, map, 0), a
p bump(a, map, 4), a
f = [0.5, 1.5, 2.5]
p f[idx(1)], f[idx(-1)], f[idx(7)]
f[idx(2)] = 4.5
p f
h = [1, miss, 3]
p h[idx(1)], h[idx(2)]
h[idx(1)] = 8
p h
begin
  p a[miss]
rescue TypeError => e
  puts "read: #{e.message}"
end
begin
  a[miss] = 3
rescue TypeError => e
  puts "write: #{e.message}"
end
p a
