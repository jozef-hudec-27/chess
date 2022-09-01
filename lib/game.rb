require_relative 'display'
require_relative 'player'
require_relative 'pieces'

# Main class including main logic of the game
class Chess
  attr_reader :board

  def initialize(board = nil, player1 = Player.new('white', self), player2 = Player.new('black', self))
    @board = board || assemble_board
    @player1 = player1
    @player2 = player2
  end

  def assemble_board
    base = Array.new(8) { Array.new(8, nil) }

    base[0][0], base[0][-1] = Rook.new('black'), Rook.new('black')
    base[0][1], base[0][-2] = Knight.new('black'), Knight.new('black')
    base[0][2], base[0][-3] = Bishop.new('black'), Bishop.new('black')
    base[0][3], base[0][4] = Queen.new('black'), King.new('black')
    base[1] = Array.new(8) { Pawn.new('black') }

    base[6] = Array.new(8) { Pawn.new('white') }
    base[7][0], base[7][-1] = Rook.new('white'), Rook.new('white')
    base[7][1], base[7][-2] = Knight.new('white'), Knight.new('white')
    base[7][2], base[7][-3] = Bishop.new('white'), Bishop.new('white')
    base[7][3], base[7][4] = Queen.new('white'), King.new('white')

    base
  end

  def pretty_print_board
    pretty_row = ->(row) { row.map { |pos| pos.nil? ? ' ' : pos.unicode } }
    pretty_board = board.map { |row| pretty_row.call(row) }
    pretty_board.each { |row| p row }
  end
end

c = Chess.new
c.pretty_print_board
