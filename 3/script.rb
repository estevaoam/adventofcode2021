require 'matrix'

raw_input = File.foreach('./input.txt')

input = Matrix[*raw_input.map { |l| l.strip.chars.map(&:to_i).flatten }]

row_size = input.row_size
column_size = input.column_size

puts "------"
### Part 1
gamma_rate = input.transpose.to_a.map {|v| (v.to_a.reduce(:+) >= (row_size / 2)) ? 1 : 0 }
epsilon_rate = gamma_rate.map { |n| (n - 1).abs }

gamma_rate = gamma_rate.join.to_i(2)
epsilon_rate = epsilon_rate.join.to_i(2)

puts "Gamma rate: #{gamma_rate} (#{gamma_rate.to_s(2)})"
puts "Epsilon rate: #{epsilon_rate} (#{epsilon_rate.to_s(2)})"
puts "Power consumption: #{gamma_rate * epsilon_rate}"

### Part 2
def select_with_bit(matrix, col_idx = 0, &block)
  n1 = matrix.column(col_idx).reduce(:+)
  n0 = matrix.row_size - n1

  bit = yield n1, n0

  selected_rows = matrix.to_a.select { |n| n[col_idx] == bit }

  return selected_rows.to_a[0].join if selected_rows.size == 1

  select_with_bit(Matrix[*selected_rows], col_idx + 1, &block)
end

o2 = select_with_bit(input) { |n1, n0| n1 >= n0 ? 1 : 0 }
co2 = select_with_bit(input) { |n1, n0| n1 >= n0 ? 0 : 1 }

puts "------"
puts " O2 rate: #{o2} (#{o2.to_i(2)})"
puts "CO2 rate: #{co2} (#{co2.to_i(2)})"
puts "  Result: #{o2.to_i(2) * co2.to_i(2)}"

