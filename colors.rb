# Monkey patch String class to make it colorful

FG_BLACK = 30
FG_RED = 31
FG_GREEN = 32
FG_YELLOW = 33
FG_BLUE = 34
FG_MAGENTA = 35
FG_CYAN = 36
FG_WHITE = 37

BG_BLACK = 40
BG_RED = 41
BG_GREEN = 42
BG_YELLOW = 43
BG_BLUE = 44
BG_MAGENTA = 45
BG_CYAN = 46
BG_WHITE = 47

String.class_eval do
  def colorize(*args)
    args.each do |number|
      if number
        self.prepend("\e[#{number}m")
        self.concat("\e[0m")
      end
    end
    return self
  end
end
