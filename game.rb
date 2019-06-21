require 'io/console'

require_relative 'colors.rb'

directions = [
  :up, :left, :down, :right
]

keysets = [
  'wasd', 'khjl'
]

direction_of = keysets.map do |keyset|
  keyset.chars.zip(directions)
end.flatten(1).to_h

ruby = { symbol: '@', colors: [FG_RED], location: [20, 20] }
words = [
  { symbol: 'R', name: 'ruby', type: 'noun', colors: [FG_RED], location: [10, 10] },
  { symbol: 'I', name: 'is', type: 'copula', colors: [FG_WHITE, BG_BLACK], location: [11, 10] },
  { symbol: 'Y', name: 'you', type: 'adjective', colors: [FG_BLUE, BG_WHITE], location: [12, 10] }
]
items = [
  { symbol: '%', name: 'skull', type: 'item', colors: [FG_RED], location: [20, 10] },
  { symbol: '~', name: 'water', type: 'item', colors: [FG_WHITE, BG_BLUE], location: [20, 11] },
  { symbol: '#', name: 'grass', type: 'item', colors: [FG_GREEN, BG_BLACK], location: [20, 12] },
  { symbol: '!', name: 'flag', type: 'item', colors: [FG_YELLOW], location: [10, 22] },
  { symbol: '0', name: 'rock', type: 'item', colors: [FG_YELLOW], location: [32, 15] },
  { symbol: '*', name: 'lava', type: 'item', colors: [FG_YELLOW, BG_RED], location: [32, 10] },
  { symbol: '&', name: 'keke', type: 'item', colors: [FG_BLACK, BG_RED], location: [12, 5] },
  { symbol: '/', name: 'ice', type: 'item', colors: [FG_BLUE, BG_WHITE], location: [22, 25] }
]

loop do
  system "clear" or system "cls"
  layout = []
  40.times do |y_index|
    layout.push([])
    80.times do |x_index|
      if ruby[:location].first == x_index && ruby[:location].last == y_index
        layout.last.push(ruby[:symbol].clone.colorize(*ruby[:colors]))
      else
        found = false
        words.each do |special|
          if special[:location].first == x_index && special[:location].last == y_index
            layout.last.push(special[:symbol].clone.colorize(*special[:colors]))
            found = true
            break
          end
        end
        items.each do |item|
          if item[:location].first == x_index && item[:location].last == y_index
            layout.last.push(item[:symbol].clone.colorize(*item[:colors]))
            found = true
            break
          end
        end
        layout.last.push(' ') unless found
      end
    end
  end

  layout.each do |row|
    puts row.join('')
  end

  input = STDIN.getch
  break if input == "\x03"

  case direction_of[input]
    when :up
      ruby[:location] = [ruby[:location].first, ruby[:location].last - 1]
    when :down
      ruby[:location] = [ruby[:location].first, ruby[:location].last + 1]
    when :left
      ruby[:location] = [ruby[:location].first - 1, ruby[:location].last]
    when :right
      ruby[:location] = [ruby[:location].first + 1, ruby[:location].last]
  end

  words.each do |special|
    if ruby[:location] == special[:location]
      case direction_of[input]
        when :up
          special[:location] = [special[:location].first, special[:location].last - 1]
        when :down
          special[:location] = [special[:location].first, special[:location].last + 1]
        when :left
          special[:location] = [special[:location].first - 1, special[:location].last]
        when :right
          special[:location] = [special[:location].first + 1, special[:location].last]
      end
    end
  end
end
