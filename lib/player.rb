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
    Player.valid_coordinate?(input)
  end

  def choose_new_position(selected_piece_cord)
    puts 'Choose where you want to move selected piece.'
    # puts "Available moves: #{available_moves(selected_piece_cord).join(' ')}"

    loop do
      position = gets.chomp
      return position if position_input_valid?(position)

      puts 'Invalid position.'
    end
  end

  def position_input_valid?(input)
    return false unless Player.valid_coordinate?(input)

    row, col = *Player.coordinate_to_row_col(input)
    @board.board[row][col].nil?
  end

  def self.coordinate_to_row_col(cord)
    row = 8 - cord[1].to_i
    col = cord[0].ord - 'a'.ord
    [row, col]
  end

  def self.valid_coordinate?(input)
    'abcdefgh'.include?(input&.dig(0)) && '12345678'.include?(input&.dig(1))
  end
end
