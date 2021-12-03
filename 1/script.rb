depths = File.readlines('./input.txt').map(&:to_i)

increasing_inputs = depths.each_cons(2).select { |(a, b)| b > a }.size
puts "Size increases: #{increasing_inputs}"

increasing_sum_of_3 = depths.each_cons(3).inject(:+).each_cons(2).select { |(a, b)| b > a }.size
binding.irb
puts "Sum increases: #{increasing_sum_of_3}"


