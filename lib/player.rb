require_relative 'pieces'
require_relative 'display'

class Player
  attr_reader :color, :chess

  def initialize(color, chess)
    @color = color
    @chess = chess
  end

  def choose_piece
    puts TerminalMessages.choose_piece_msg

    loop do
      position = gets.chomp
      return position if piece_input_valid?(position) || ['save', 'quit'].include?(position)

      puts TerminalMessages.invalid_piece_msg
    end
  end

  def piece_input_valid?(input)
    return false unless Player.valid_coordinate?(input)

    row, col = *Player.coordinate_to_row_col(input)
    chess.board[row][col]&.player == self
  end

  def choose_new_position(selected_piece)
    print_new_position_info(selected_piece)
    available_moves = get_all_moves(selected_piece)[1]

    loop do
      position = gets.chomp
      return position if available_moves.include?(position)

      puts TerminalMessages.invalid_position_msg
    end
  end

  def print_new_position_info(selected_piece)
    available_moves, available_moves_cord, available_takes, available_takes_cord, available_moves_wo_takes = *get_all_moves(selected_piece)

    puts TerminalMessages.choose_position_msg
    puts TerminalMessages.available_moves_msg(available_moves_wo_takes) unless available_moves_wo_takes.empty?
    puts TerminalMessages.available_takes_msg(available_takes_cord) unless available_takes_cord.empty?
  end

  def get_all_moves(selected_piece)
    available_moves = selected_piece.available_moves
    available_moves_cord = available_moves.map { |r, c| Player.row_col_to_coordinate(r, c) }
    available_takes = selected_piece.available_takes
    available_takes_cord = available_takes.map { |r, c| Player.row_col_to_coordinate(r, c) }
    available_moves_wo_takes = available_moves_cord - available_takes_cord

    [available_moves, available_moves_cord, available_takes, available_takes_cord, available_moves_wo_takes]
  end

  def move_piece(from, to)
    to_row, to_col = *Player.coordinate_to_row_col(to)
    from_row, from_col = *Player.coordinate_to_row_col(from)
    moved_piece = chess.find_piece(from)
    moved_piece.set_position(to_row, to_col)
    transform_pawn(moved_piece, from_row, from_col, to_row, to_col) if [0,
                                                                        7].include?(to_row) && moved_piece.instance_of?(Pawn)
  end

  def transform_pawn(pawn, original_row, original_col, new_row, new_col)
    puts TerminalMessages.pawn_can_transform_msg
    transform_to = new_pawn_input
    transformed_piece = [Queen, Rook, Knight, Bishop][transform_to - 1].new(self, original_row, original_col)
    transformed_piece.set_position(new_row, new_col)
  end

  def new_pawn_input
    puts TerminalMessages.choose_pawn_transformation_msg

    loop do
      input = gets.chomp
      return input.to_i if ['1', '2', '3', '4'].include?(input)

      puts TerminalMessages.invalid_input_msg
    end
  end

  def self.coordinate_to_row_col(cord)
    row = 8 - cord[1].to_i
    col = cord[0].ord - 'a'.ord
    [row, col]
  end

  def self.row_col_to_coordinate(row, col)
    r = (8 - row).to_s
    c = ('a'.ord + col).chr
    c + r
  end

  def self.valid_coordinate?(input)
    return false unless input.length == 2

    input = input.split('')
    'abcdefgh'.include?(input[0]) && '12345678'.include?(input[1])
  end
end
