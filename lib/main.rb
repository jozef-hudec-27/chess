require_relative 'utils'

Dir.mkdir('savefiles') unless Dir.exist?('savefiles')

loop do
  game.play
end
