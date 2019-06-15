require 'io/console'

ruby = { symbol: '@', location: [20, 20] }
specials = [
  { symbol: 'R', location: [10, 10] },
  { symbol: 'I', location: [11, 10] },
  { symbol: 'Y', location: [12, 10] }
]

loop do
  system "clear" or system "cls"
  layout = []
  40.times do |y_index|
    layout.push([])
    80.times do |x_index|
      if ruby[:location].first == x_index && ruby[:location].last == y_index
        layout.last.push(ruby[:symbol])
      else
        found = false
        specials.each do |special|
          if special[:location].first == x_index && special[:location].last == y_index
            layout.last.push(special[:symbol])
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

  if input == 'w'
    ruby[:location] = [ruby[:location].first, ruby[:location].last - 1]
  elsif input == 's'
    ruby[:location] = [ruby[:location].first, ruby[:location].last + 1]
  elsif input == 'a'
    ruby[:location] = [ruby[:location].first - 1, ruby[:location].last]
  elsif input == 'd'
    ruby[:location] = [ruby[:location].first + 1, ruby[:location].last]
  end

  specials.each do |special|
    if ruby[:location] == special[:location]
      if input == 'w'
        special[:location] = [special[:location].first, special[:location].last - 1]
      elsif input == 's'
        special[:location] = [special[:location].first, special[:location].last + 1]
      elsif input == 'a'
        special[:location] = [special[:location].first - 1, special[:location].last]
      elsif input == 'd'
        special[:location] = [special[:location].first + 1, special[:location].last]
      end
    end
  end
end
