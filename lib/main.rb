require_relative 'utils'

Dir.mkdir('savefiles') unless Dir.exist?('savefiles')

loop do
  game.play

  puts TerminalMessages.play_again_confirm_msg
  break unless gets.chomp == 'y'
end

puts TerminalMessages.goodbye_msg
