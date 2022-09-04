# Class that allows us to use colors in the terminal
class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  
  def bold;           "\e[1m#{self}\e[22m" end
end
