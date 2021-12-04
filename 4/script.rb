input = File.readlines('./input.txt')

numbers_to_draw = input[0].strip.split(',').map(&:to_i).each_with_index.to_h

board_n = 0
all_boards = input[2..-1].each_with_object([]) do |line, boards|
  raw_input = line.strip

  next (board_n += 1) if raw_input.size == 0

  row_numbers = raw_input.squeeze(' ').split(/\s/).map(&:to_i)

  boards[board_n] ||= { rows: [], cols: [] }
  boards[board_n][:rows] << row_numbers

  row_numbers.each_with_index do |number, idx|
    (boards[board_n][:cols][idx] ||= []) << number
  end
end

all_boards.map! { |object| object[:rows] + object[:cols] }
original_boards = Marshal.load(Marshal.dump(all_boards))

drawn_numbers = numbers_to_draw.invert

winner_boards = all_boards.each_with_index.map do |board, board_idx|
  winning_sets = board.select { |set| (set & numbers_to_draw.keys) == set }
  winner_set = winning_sets.min_by { |set| numbers_to_draw.values_at(*set).max }

  time_vector = numbers_to_draw.values_at(*winner_set)
  numbers_drawn = numbers_to_draw.select { |number, time| time <= time_vector.max }.keys

  if winner_set
    {
      idx: board_idx,
      board: board,
      winner_set: winner_set,
      numbers_drawn: numbers_drawn,
      drawn_number_at_winning: numbers_drawn.last
    }
  end
end.compact

winner_board = winner_boards.min_by { |b| b[:numbers_drawn].size }

unmarked_numbers = winner_board[:board].flatten.uniq - winner_board[:numbers_drawn]
unmarked_sum = unmarked_numbers.sum

wb = winner_board
puts "Part 1 ==============================="
puts "All drawn numbers: #{wb[:numbers_drawn]}"
puts "Last number: #{wb[:drawn_number_at_winning]}"
puts "Winner board: #{wb[:idx]}"
puts "Winner set: #{wb[:winner_set]}"
puts "Original board:"
pp wb[:board]
puts "Unmarked numbers: #{unmarked_numbers}"
puts "Sum: #{unmarked_sum}"
puts "Result: #{unmarked_sum * wb[:drawn_number_at_winning]}"

# p2
winner_board = winner_boards.max_by { |b| b[:numbers_drawn].size }

unmarked_numbers = winner_board[:board].flatten.uniq - winner_board[:numbers_drawn]
unmarked_sum = unmarked_numbers.sum

puts
puts "Part 2 ==============================="
wb = winner_board
puts "All drawn numbers: #{wb[:numbers_drawn]}"
puts "Last number: #{wb[:drawn_number_at_winning]}"
puts "Winner board: #{wb[:idx]}"
puts "Winner set: #{wb[:winner_set]}"
puts "Original board:"
pp wb[:board]
puts "Unmarked numbers: #{unmarked_numbers}"
puts "Sum: #{unmarked_sum}"
puts "Result: #{unmarked_sum * wb[:drawn_number_at_winning]}"


