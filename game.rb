# Tic Tac Toe Game
# Ruby implementation of a simple command-line Tic Tac Toe game.
# The game allows two players to take turns marking their spots on a 3x3 grid.
# Players can enter their moves in the format "row,col".

class TicTacToe

    def initialize
        @board = Array.new(3) { Array.new(3, ' ') }
        @current_player = 'X'
    end

    def play
        loop do
            print_board
            row, col = get_move
            if valid_move?(row, col)
                @board[row][col] = @current_player
                if winner?
                    print_board
                    puts "Player #{@current_player} wins!"
                    break
                elsif board_full?
                    print_board
                    puts "It's a draw!"
                    break
                else
                    switch_player
                end
            else
                puts "Invalid move. Try again."
            end
        end
    end

    private

    # The board should show the coordinates of each cell
    def print_board
        puts "   0   1   2"
        @board.each_with_index do |row, i|
            display_row = row.map { |cell| cell == ' ' ? '   ' : " #{cell} " }
            puts "#{i} #{display_row.join('|')}"
            puts "   --+---+---" unless i == 2
        end
    end

    def ai_move
        @board.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                return [i, j] if cell == ' '
            end
        end
        [-1, -1]
    end

    def get_move
        if @current_player == 'O'
            ai_move
        else
            print "Player #{@current_player}, enter your move (row,col): "
            input = gets.chomp
            if input =~ /^\d,\d$/
                input.split(',').map(&:to_i)
            else
                [-1, -1]
            end
        end
    end

    def valid_move?(row, col)
        row.between?(0,2) && col.between?(0,2) && @board[row][col] == ' '
    end

    def switch_player
        @current_player = @current_player == 'X' ? 'O' : 'X'
    end

    def winner?
        lines = @board + @board.transpose +
                        [[@board[0][0], @board[1][1], @board[2][2]],
                         [@board[0][2], @board[1][1], @board[2][0]]]
        lines.any? { |line| line.all? { |cell| cell == @current_player } }
    end

    def board_full?
        @board.flatten.none? { |cell| cell == ' ' }
    end
end

if __FILE__ == $0
    TicTacToe.new.play
end
