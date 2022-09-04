require_relative 'chess'
require_relative 'display'
require 'yaml'

def game
  option = game_option
  return [Chess.new, nil] if option == '1'

  load_game
end

def game_option
  puts TerminalMessages.choose_game_msg

  loop do
    option = gets.chomp
    return option if ['1', '2'].include?(option)

    puts TerminalMessages.invalid_game_option_msg
  end
end

def savefiles_directory
  Dir.new('savefiles')
end

def load_game
  savename = load_game_name

  msg_and_sleep(savename == 'q' ? 'Starting a new game...' : "Loading #{savename}...", 1)

  return [Chess.new, nil] if savename == 'q'

  serialized = File.read("savefiles/#{savename}.yaml")
  [YAML.load(serialized, aliases: true, permitted_classes: [Chess, Player, Rook, Knight, Bishop, Queen, King, Pawn]), savename]
end

def load_game_name
  savenames = savefiles_directory.children.map { |filename| filename.split('.')[0] }

  puts TerminalMessages.choose_save_msg(savenames)
  puts TerminalMessages.quit_loading_game_msg 

  loop do
    savename = gets.chomp
    return savename if savenames.include?(savename) || savename == 'q'

    puts TerminalMessages.no_save_found_msg
  end
end

def msg_and_sleep(msg, sleep_time)
  puts msg
  sleep(sleep_time)
end
