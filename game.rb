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
specials = [
  { symbol: 'R', colors: [FG_RED], location: [10, 10] },
  { symbol: 'I', colors: [FG_WHITE, BG_BLACK], location: [11, 10] },
  { symbol: 'Y', colors: [FG_BLUE, BG_WHITE], location: [12, 10] }
]
items = [
  { symbol: 'X', colors: [FG_RED], location: [20, 10] }
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
        specials.each do |special|
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

  specials.each do |special|
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
