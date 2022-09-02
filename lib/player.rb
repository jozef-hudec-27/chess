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
    puts 'Choose where you want to move selected piece.'
    available_moves = selected_piece.available_moves.map { |r, c| Player.row_col_to_coordinate(r, c) }
    puts "Available moves: #{available_moves.join(' ') }"

    loop do
      position = gets.chomp
      return position if available_moves.include?(position)

      puts 'Invalid position.'
    end
  end

  def move_piece(from, to)
    from_row, from_col = *Player.coordinate_to_row_col(from)
    to_row, to_col = *Player.coordinate_to_row_col(to)
    moved_piece = board.find_piece(from)
    moved_piece.row = Player.coordinate_to_row_col(to)[0]
    moved_piece.col = Player.coordinate_to_row_col(to)[1]
    board.board[from_row][from_col] = nil
    board.board[to_row][to_col] = moved_piece
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
