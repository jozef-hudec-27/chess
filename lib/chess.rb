require_relative 'display'
require_relative 'player'
require_relative 'pieces'
require 'yaml'

# Main class including main logic of the game
class Chess
  attr_reader :board, :player1, :player2, :current_player, :round

  def initialize(board = nil, player1 = Player.new('white', self), player2 = Player.new('black', self))
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @round = 0
    @board = board || assemble_board
  end

  def round_update
    self.round = round + 1
    change_current_player
  end

  def change_current_player
    self.current_player = player1 == current_player ? player2 : player1
  end

  def play
    end_ = game_loop
    game_over_output if end_
  end

  def save
    serialized_game = YAML.dump(self)
    savename = new_save_name
    Dir.mkdir('savefiles') unless Dir.exist?('savefiles')
    File.open("savefiles/#{savename}.yaml", 'w') { |file| file.puts serialized_game }

    puts(TerminalMessages.saving_game_msg(savename)) || sleep(1)
    false
  end

  def new_save_name
    puts TerminalMessages.new_save_name_question_msg

    loop do
      name = gets.chomp
      return name if Chess.save_name_valid?(name)

      puts TerminalMessages.invalid_savename_msg
    end
  end

  def game_loop
    until game_over?
      pretty_print_board
      puts TerminalMessages.new_round_msg(round + 1, current_player.color)
      piece_cord = current_player.choose_piece

      if ['save', 'quit'].include?(piece_cord)
        return Chess.quit_game if piece_cord == 'quit'

        return save
      end

      if find_piece(piece_cord).available_moves.empty?
        puts TerminalMessages.moveless_piece_msg
        next
      end

      new_cord = current_player.choose_new_position(find_piece(piece_cord))
      current_player.move_piece(piece_cord, new_cord)
      round_update
    end

    true
  end

  def game_over_output
    pretty_print_board

    return puts TerminalMessages.game_draw_msg if stalemate?

    is_king1_mated = find_king(player1).mated?(current_player)

    return puts TerminalMessages.game_winner_msg(player2, player1) if is_king1_mated

    puts TerminalMessages.game_winner_msg(player1, player2)
  end

  def game_over?
    mate? || stalemate?
  end

  def mate?
    find_king(player1).mated?(current_player) || find_king(player2).mated?(current_player)
  end

  def stalemate?
    find_king(player1).stalemated? || find_king(player2).stalemated?
  end

  def find_king(player)
    8.times do |row|
      8.times do |col|
        piece = board[row][col]
        return piece if piece.instance_of?(King) && piece.player == player 
      end
    end
  end

  def find_piece(cord)
    row, col = *Player.coordinate_to_row_col(cord)
    board[row][col]
  end

  def assemble_board
    base = Array.new(8) { Array.new(8, nil) }

    base[0][0], base[0][-1] = Rook.new(player2, 0, 0), Rook.new(player2, 0, 7)
    base[0][1], base[0][-2] = Knight.new(player2, 0, 1), Knight.new(player2, 0, 6)
    base[0][2], base[0][-3] = Bishop.new(player2, 0, 2), Bishop.new(player2, 0, 5)
    base[0][3], base[0][4] = Queen.new(player2, 0, 3), King.new(player2, 0, 4)
    8.times { |i| base[1][i] = Pawn.new(player2, 1, i) }

    8.times { |i| base[6][i] = Pawn.new(player1, 6, i) }
    base[7][0], base[7][-1] = Rook.new(player1, 7, 0), Rook.new(player1, 7, 7)
    base[7][1], base[7][-2] = Knight.new(player1, 7, 1), Knight.new(player1, 7, 6)
    base[7][2], base[7][-3] = Bishop.new(player1, 7, 2), Bishop.new(player1, 7, 5)
    base[7][3], base[7][4] = Queen.new(player1, 7, 3), King.new(player1, 7, 4)

    base
  end

  def pretty_print_board
    pretty_row = ->(row, i) { [8 - i] + row.each_with_index.map { |pos, j| pos.nil? ? [Unicode.square_white, Unicode.square_black][(j + i) % 2] : pos.unicode } }
    pretty_board = board.each_with_index.map { |row, i| pretty_row.call(row, i) }
    pretty_board.unshift(["  #{'abcdefgh'.split('').join(' ')}"])
    puts "\n"
    pretty_board.each { |row| puts row.join(' ') }
  end

  def position_valid?(row, col, piece)
    return false if row.negative? || col.negative? || row > 7 || col > 7

    board[row][col].nil? || (board[row][col].player.color != piece.player.color ? 'take' : false)
  end

  def self.save_name_valid?(name)
    return false if name == '' || name[0] == '-'

    valid_chars = 'abcdefghijklmnopqrstuvwxyz0123456789-_'

    name.chars.each do |char|
      return false unless valid_chars.include?(char)
    end

    true
  end

  def self.quit_game
    puts(TerminalMessages.quitting_game_msg) || sleep(1)
    
    false
  end

  private

  attr_writer :board, :current_player, :round
end
