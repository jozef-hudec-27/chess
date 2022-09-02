require_relative 'display'

class Piece
  attr_reader :player, :row, :col, :board

  def initialize(player, row, col)
    @player = player
    @row = row
    @col = col
    @board = player.board
  end
end

class King < Piece
  def unicode
    @player.color == 'black' ? Display.king_black : Display.king_white
  end

  def available_moves
    moves = []
    transformations = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

    transformations.each do |add_to_row, add_to_col|
      new_row, new_col = row + add_to_row, col + add_to_col
      moves.push([new_row, new_col]) if board.position_valid?(new_row, new_col, self)
    end

    moves
  end
end

class Queen < Piece
  def unicode
    @player.color == 'black' ? Display.queen_black : Display.queen_white
  end

  def self.available_moves(row, col, board)
  end
end

class Rook < Piece
  def unicode
    @player.color == 'black' ? Display.bishop_black : Display.bishop_white
  end

  def available_moves
    moves = []

    directions = [[-1, 0], [0, 1], [1, 0], 0, -1]
    directions.each do |add_to_row, add_to_col|
      new_row, new_col = row + add_to_row, col + add_to_col

      loop do
        pos_val = board.position_valid?(new_row, new_col, self)
        moves.push([new_row, new_col]) if pos_val
        break if !pos_val || pos_val == 'take'

        new_row, new_col = new_row + add_to_row, new_col + add_to_col
      end
    end

    moves
  end
end

class Bishop < Piece
  def unicode
    @player.color == 'black' ? Display.bishop_black : Display.bishop_white
  end

  def available_moves
    moves = []

    directions = [[-1, -1], [-1, 1], [1, -1], 1, 1]
    directions.each do |add_to_row, add_to_col|
      new_row, new_col = row + add_to_row, col + add_to_col

      loop do
        pos_val = board.position_valid?(new_row, new_col, self)
        moves.push([new_row, new_col]) if pos_val
        break if !pos_val || pos_val == 'take'

        new_row, new_col = new_row + add_to_row, new_col + add_to_col
      end
    end

    moves
  end
end

class Knight < Piece
  def unicode
    @player.color == 'black' ? Display.knight_black : Display.knight_white
  end

  def self.available_moves(row, col, board)
  end
end

class Pawn < Piece
  def unicode
    @player.color == 'black' ? Display.pawn_black : Display.pawn_white
  end

  def self.available_moves(row, col, board)
  end
end
