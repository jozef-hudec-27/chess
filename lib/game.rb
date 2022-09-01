require_relative 'display'
require_relative 'player'

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

    base[0][0], base[0][-1] = Display.rook_black, Display.rook_black
    base[0][1], base[0][-2] = Display.knight_black, Display.knight_black
    base[0][2], base[0][-3] = Display.bishop_black, Display.bishop_black
    base[0][3], base[0][4] = Display.queen_black, Display.king_black
    base[1] = Array.new(8, Display.pawn_black)

    base[6] = Array.new(8, Display.pawn_white)
    base[7][0], base[7][-1] = Display.rook_white, Display.rook_white
    base[7][1], base[7][-2] = Display.knight_white, Display.knight_white
    base[7][2], base[7][-3] = Display.bishop_white, Display.bishop_white
    base[7][3], base[7][4] = Display.queen_white, Display.king_white

    base
  end
end

c = Chess.new
p c.board
