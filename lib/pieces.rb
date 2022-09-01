require_relative 'display'

class Piece
  def initialize(color)
    @color = color
  end
end

class King < Piece
  def unicode
    @color == 'black' ? Display.king_black : Display.king_white
  end

  def self.available_moves(row, col, board)
  end
end

class Queen < Piece
  def unicode
    @color == 'black' ? Display.queen_black : Display.queen_white
  end

  def self.available_moves(row, col, board)
  end
end

class Rook < Piece
  def unicode
    @color == 'black' ? Display.bishop_black : Display.bishop_white
  end

  def self.available_moves(row, col, board)
  end
end

class Bishop < Piece
  def unicode
    @color == 'black' ? Display.bishop_black : Display.bishop_white
  end

  def self.available_moves(row, col, board)
  end
end

class Knight < Piece
  def unicode
    @color == 'black' ? Display.knight_black : Display.knight_white
  end

  def self.available_moves(row, col, board)
  end
end

class Pawn < Piece
  def unicode
    @color == 'black' ? Display.pawn_black : Display.pawn_white
  end

  def self.available_moves(row, col, board)
  end
end
