module Unicode
  def self.king_white
    '♔'
  end

  def self.king_black
    '♚'
  end

  def self.queen_white
    '♕'
  end

  def self.queen_black
    '♛'
  end

  def self.pawn_white
    '♙'
  end

  def self.pawn_black
    '♟'
  end

  def self.rook_white
    '♖'
  end

  def self.rook_black
    '♜'
  end

  def self.knight_white
    '♘'
  end

  def self.knight_black
    '♞'
  end

  def self.bishop_white
    '♗'
  end

  def self.bishop_black
    '♝'
  end

  def self.square_white
    '□'
  end

  def self.square_black
    '■'
  end
end

module TerminalMessages
  def self.new_round_msg(round, color)
    "ROUND #{round}: #{color}"
  end

  def self.moveless_piece_msg
    "You can't make a move with this piece. Select a new one."
  end

  def self.game_draw_msg
    "It's a draw!"
  end

  def self.game_winner_msg(winner, loser)
    "#{loser.color} is mated. #{winner.color} wins!"
  end

  def self.choose_piece_msg
    'Choose the piece you want to move.'
  end

  def self.invalid_piece_msg
    'Invalid piece position.'
  end

  def self.invalid_position_msg
    'Invalid position.'
  end

  def self.invalid_input_msg
    'Invalid input. Please enter again.'
  end

  def self.choose_position_msg
    'Choose where you want to move selected piece'
  end

  def self.available_moves_msg(moves)
    "Available moves: #{moves.join(' ')}"
  end

  def self.available_takes_msg(takes)
    "Available takes: #{takes.join(' ')}"
  end

  def self.pawn_can_transform_msg
    'Your pawn reached the other side of the board! You can transform it to a Queen (1), Rook (2), Knight (3) or Bishop (4)'
  end

  def self.choose_pawn_transformation_msg
    'Enter a number 1 to 4 of the piece you want to transform to.'
  end
end
