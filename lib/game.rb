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
    pretty_row = ->(row) { row.map { |pos| pos.nil? ? ' ' : pos.unicode } }
    pretty_board = board.map { |row| pretty_row.call(row) }
    pretty_board.each { |row| p row }
  end

  def position_valid?(row, col, piece)
    return false if row.negative? || col.negative? || row > 7 || col > 7

    board[row][col].nil? || (board[row][col].player.color != piece.player.color ? 'take' : false)
  end
end

c = Chess.new
p c.board[0][0].available_moves
