# `Hash#fetch(k, nil)` on an Integer-valued Hash answers nil on a miss. The
# value is typed Integer and carries nil as the sentinel, but the analysis did
# not count the nil default, so a strict Integer argument read the sentinel
# as the number -2**63: `"ab" * x` raised ArgumentError (negative argument)
# instead of TypeError.
def t(label)
  print label, ": "
  p yield
rescue => e
  puts "#{e.class}: #{e.message}"
end

ih = {1 => 2}
sh = {"a" => 3}

miss = ih.fetch(3, nil)
t("miss") { miss }
t("miss nil?") { miss.nil? }
t("miss * ") { "ab" * miss }
t("miss first") { [1, 2].first(miss) }

smiss = sh.fetch("z", nil)
t("str key miss * ") { "ab" * smiss }

bmiss = ih.fetch(3) { nil }
t("block miss * ") { "ab" * bmiss }

hit = ih.fetch(1, nil)
t("hit") { hit }
t("hit * ") { "ab" * hit }

# already counted as nil: a parameter only nil is passed to, and an
# argument splatted out of a boxed Array
def only_nil(x) = "ab" * x
t("only nil param") { only_nil(nil) }
def second(a, b) = "ab" * b
arr = [1, "x"]
arr = [1, nil] if ARGV.empty?
t("splat") { second(*arr) }
