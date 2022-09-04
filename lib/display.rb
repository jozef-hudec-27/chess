require_relative 'color'

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
    "ROUND #{round}: #{color}".bold
  end

  def self.moveless_piece_msg
    "You can't make a move with this piece. Select a new one."
  end

  def self.game_draw_msg
    "It's a draw!"
  end

  def self.game_winner_msg(winner, loser)
    "#{loser.color} is mated. #{winner.color} wins!".green.bold
  end

  def self.choose_piece_msg
    '> Choose the piece you want to move.'.blue
  end

  def self.invalid_piece_msg
    'Invalid piece position.'.red.bold
  end

  def self.invalid_position_msg
    'Invalid position.'.red.bold
  end

  def self.invalid_input_msg
    'Invalid input. Please enter again.'.red.bold
  end

  def self.choose_position_msg
    '> Choose where you want to move selected piece'.blue
  end

  def self.available_moves_msg(moves)
    "> Available moves: #{moves.join(' ')}".blue
  end

  def self.available_takes_msg(takes)
    "> Available takes: #{takes.join(' ')}".red
  end

  def self.pawn_can_transform_msg
    'Your pawn reached the other side of the board! You can transform it to a Queen (1), Rook (2), Knight (3) or Bishop (4)'
  end

  def self.choose_pawn_transformation_msg
    '> Enter a number 1 to 4 of the piece you want to transform to.'.blue
  end

  def self.choose_game_msg
    '> Do you want to play a new game (1) or load an existing game (2)?'.blue
  end

  def self.invalid_game_option_msg
    "Please, enter only '1' or '2'.".red.bold
  end

  def self.choose_save_msg(files)
    "> Choose one of these files: #{files.join(', ')}".blue
  end

  def self.quit_loading_game_msg
    "> If you changed your mind, enter 'q' to start a new game."
  end

  def self.no_save_found_msg
    "There's no such savefile.".red.bold
  end

  def self.invalid_savename_msg
    '> This savename is invalid. Enter a new one.'.red.bold
  end

  def self.new_save_name_question_msg
    '> What do you want to name your save?'
  end

  def self.saving_game_msg(filename)
    "Saving current game as '#{filename}'..."
  end

  def self.quitting_game_msg
    '> Quitting current game...'
  end

  def self.play_again_confirm_msg
    "Do you want to play again? Enter 'y' if so."
  end

  def self.goodbye_msg
    'Have a nice day!'
  end
end
