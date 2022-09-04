require_relative 'pieces'

class Player
  attr_reader :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

  def choose_piece
    puts 'Choose the piece you want to move.'

    loop do
      position = gets.chomp
      return position if piece_input_valid?(position)

      puts 'Invalid piece position.'
    end
  end

  def piece_input_valid?(input)
    return false unless Player.valid_coordinate?(input)

    row, col = *Player.coordinate_to_row_col(input)
    board.board[row][col]&.player == self
  end

  def choose_new_position(selected_piece)
    print_new_position_info(selected_piece)
    available_moves = get_all_moves(selected_piece)[1]

    loop do
      position = gets.chomp
      return position if available_moves.include?(position)

      puts 'Invalid position.'
    end
  end

  def print_new_position_info(selected_piece)
    available_moves, available_moves_cord, available_takes, available_takes_cord, available_moves_wo_takes = *get_all_moves(selected_piece)

    puts 'Choose where you want to move selected piece'.red
    puts "Available moves: #{available_moves_wo_takes.join(' ')}" unless available_moves_wo_takes.empty?
    puts "Available takes: #{available_takes_cord.join(' ')}" unless available_takes_cord.empty?
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
    moved_piece = board.find_piece(from)
    moved_piece.set_position(to_row, to_col)
    transform_pawn(moved_piece, from_row, from_col, to_row, to_col) if [0, 7].include?(to_row) && moved_piece.instance_of?(Pawn)
  end

  def transform_pawn(pawn, original_row, original_col, new_row, new_col)
    puts 'Your pawn reached the other side of the board! You can transform it to a Queen (1), Rook (2), Knight (3) or Bishop (4)'
    transform_to = new_pawn_input
    transformed_piece = [Queen, Rook, Knight, Bishop][transform_to - 1].new(self, original_row, original_col)
    transformed_piece.set_position(new_row, new_col)
  end

  def new_pawn_input
    puts 'Enter a number 1 to 4 of the piece you want to transform to.'

    loop do
      input = gets.chomp
      return input.to_i if ['1', '2', '3', '4'].include?(input)

      puts 'Invalid input. Please enter again.'
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
