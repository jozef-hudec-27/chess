require_relative 'display'

class Piece
  attr_reader :player, :board
  attr_accessor :row, :col

  def initialize(player, row, col)
    @player = player
    @row = row
    @col = col
    @board = player.board
  end

  def available_moves_places(differences, piece)
    moves = []

    differences.each do |add_to_row, add_to_col|
      new_row, new_col = row + add_to_row, col + add_to_col
      moves.push([new_row, new_col]) if board.position_valid?(new_row, new_col, piece)
    end

    moves
  end

  def available_moves_traverse(directions, piece)
    moves = []

    directions.each do |add_to_row, add_to_col|
      new_row, new_col = row + add_to_row, col + add_to_col

      loop do
        pos_val = board.position_valid?(new_row, new_col, piece)
        moves.push([new_row, new_col]) if pos_val
        break if !pos_val || pos_val == 'take'

        new_row, new_col = new_row + add_to_row, new_col + add_to_col
      end
    end

    moves
  end

  def enemy_pieces
    board.board.flatten.filter { |piece| piece && piece.player.color != player.color }
  end

  def set_position(r = row, c = col)
    board.board[row][col] = nil
    board.board[r][c] = self

    self.row = r
    self.col = c
  end

  def self.DIAGONAL_TRAVERSE_DIRECTIONS
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def self.STRAIGHT_TRAVERSE_DIRECTIONS
    [[-1, 0], [0, 1], [1, 0], [0, -1]]
  end
end

class King < Piece
  def unicode
    @player.color == 'black' ? Display.king_black : Display.king_white
  end

  def available_moves
    possible_moves = available_moves_places(King.MOVE_DIFFERENCES, self)
    possible_moves - invalid_moves(possible_moves)
  end

  def invalid_moves(moves)
    invalid = []
    original_row, original_col = row, col

    moves.each do |r, c|
      set_position(r, c)

      invalid.push([r, c]) if checked?
    end

    set_position(original_row, original_col)
    invalid
  end

  def checked?
    enemy_pieces.each do |piece|
      enemy_moves = piece.instance_of?(King) ? piece.available_moves_places(King.MOVE_DIFFERENCES, piece) : piece.available_moves
      return true if enemy_moves.include?([row, col])
    end

    false
  end

  def mated?
    return false unless checked?

    original_row, original_col = row, col

    available_moves.each do |r, c|
      set_position(r, c)

      unless checked?
        set_position(original_row, original_col)
        return false
      end
    end

    set_position(original_row, original_col)

    true
  end

  def stalemated?
    return false if checked?

    invalid_moves_count = 0
    original_row, original_col = row, col

    available_moves.each do |r, c|
      set_position(r, c)

      unless checked?
        set_position(original_row, original_col)
        return false
      end

      invalid_moves_count += 1
    end

    set_position(original_row, original_col)

    !available_moves.empty? && invalid_moves == available_moves.length
  end

  def self.MOVE_DIFFERENCES
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end
end

class Queen < Piece
  def unicode
    @player.color == 'black' ? Display.queen_black : Display.queen_white
  end

  def available_moves
    available_moves_traverse(Piece.STRAIGHT_TRAVERSE_DIRECTIONS, self) +
      available_moves_traverse(Piece.DIAGONAL_TRAVERSE_DIRECTIONS, self)
  end
end

class Rook < Piece
  def unicode
    @player.color == 'black' ? Display.bishop_black : Display.bishop_white
  end

  def available_moves
    available_moves_traverse(Piece.STRAIGHT_TRAVERSE_DIRECTIONS, self)
  end
end

class Bishop < Piece
  def unicode
    @player.color == 'black' ? Display.bishop_black : Display.bishop_white
  end

  def available_moves
    available_moves_traverse(Piece.DIAGONAL_TRAVERSE_DIRECTIONS, self)
  end
end

class Knight < Piece
  def unicode
    @player.color == 'black' ? Display.knight_black : Display.knight_white
  end

  def available_moves
    available_moves_places([[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, -2], [2, -1], [1, 2], [2, 1]], self)
  end
end

class Pawn < Piece
  def unicode
    @player.color == 'black' ? Display.pawn_black : Display.pawn_white
  end

  def available_moves
    add_to_row = player.color == 'black' ? 1 : -1
    moves = []

    [-1, 1].each do |add_to_col|
      new_row, new_col = row + add_to_row, col + add_to_col
      moves.push([new_row, new_col]) if new_row.between?(0, 7) && new_col.between?(0, 7) &&
        board.board[new_row][new_col] && board.board[new_row][new_col].player.color != player.color 
    end

    moves.push([row + add_to_row, col]) if (row + add_to_row).between?(0, 7) && board.board[row + add_to_row][col].nil?
    moves.push([row + add_to_row * 2, col]) if unmoved? && board.board[row + add_to_row * 2][col].nil?
    moves
  end

  def unmoved?
    (player.color == 'black' && row == 1) || (player.color == 'white' && row == 6)
  end
end
