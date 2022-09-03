require_relative 'display'
require_relative 'player'
require_relative 'pieces'

# Main class including main logic of the game
class Chess
  attr_reader :board, :player1, :player2

  def initialize(board = nil, player1 = Player.new('white', self), player2 = Player.new('black', self))
    @player1 = player1
    @player2 = player2
    @board = board || assemble_board
  end

  def play
    game_loop
    game_over_output
  end

  def game_loop
    round = 0

    until game_over?
      pretty_print_board
      current_player = [player1, player2][round % 2]
      puts "ROUD #{round + 1}: #{current_player.color}"
      piece_cord = current_player.choose_piece

      if find_piece(piece_cord).available_moves.empty?
        puts "You can't make a move with this piece. Select a new one."
        next
      end

      new_cord = current_player.choose_new_position(find_piece(piece_cord))
      current_player.move_piece(piece_cord, new_cord)
      round += 1
    end
  end

  def game_over_output
    puts "It's a draw!" if stalemate?
    is_king1_mated = find_king(player1).mated?

    return puts "#{player1.color} is mated. #{player2.color} wins!" if is_king1_mated
    
    puts "#{player2.color} is mated. #{player1.color} wins" 
  end

  def game_over?
    mate? || stalemate?
  end

  def mate?
    find_king(player1).mated? || find_king(player2).mated?
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
    pretty_row = ->(row, i) { [8 - i] + row.map { |pos| pos.nil? ? ' ' : pos.unicode } }
    pretty_board = board.each_with_index.map { |row, i| pretty_row.call(row, i) }
    pretty_board.unshift(['   ' + 'abcdefgh'.split('').join('    ')])
    pretty_board.each { |row| p row }
  end

  def position_valid?(row, col, piece)
    return false if row.negative? || col.negative? || row > 7 || col > 7

    board[row][col].nil? || (board[row][col].player.color != piece.player.color ? 'take' : false)
  end
end

c = Chess.new
c.play
