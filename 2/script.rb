# variables: horizontal, depth
# commands: forward, down, up

input = File.foreach('./input.txt')

commands = input.each_with_object({}) do |line, hash|
  command, value = line.split(' ')
  (hash[command] ||= []) << value.to_i
end

x = commands['forward'].inject(:+)
depth = commands['down'].inject(:+) - commands['up'].inject(:+)
aim = commands['down'].inject(:+) - commands['up'].inject(:+)

puts 'Part 1'
puts '============='
puts "x: #{x}"
puts "depth: #{depth}"
puts "multiplication: #{x * depth}"

### Part 2
funcs = {
  down: -> (vars, value) { vars[:aim] += value },
  up: -> (vars, value) { vars[:aim] -= value },
  forward: -> (vars, value) {
    vars[:x] += value
    vars[:depth] += vars[:aim] * value
  }
}

results = input.each_with_object({ x: 0, depth: 0, aim: 0 }) do |line, result|
  command, value = line.split(' ')

  funcs[command.to_sym].call(result, value.to_i)
end

puts
puts 'Part 2'
puts '============='
puts "x: #{results[:x]}"
puts "depth: #{results[:depth]}"
puts "multiplication: #{results[:x] * results[:depth]}"


