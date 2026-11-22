# Run: ruby day04_object_oriented_ruby.rb
class Board
  WINNING_LINES = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].freeze

  def initialize
    @cells = Array.new(9)
  end

  def place(position, marker)
    return false unless position && position.between?(1, 9) && @cells[position - 1].nil?
    @cells[position - 1] = marker
    true
  end

  def winner
    WINNING_LINES.each do |a, b, c|
      return @cells[a] if @cells[a] && @cells[a] == @cells[b] && @cells[b] == @cells[c]
    end
    nil
  end

  def full?
    @cells.none?(&:nil?)
  end

  def display
    puts @cells.each_with_index.map { |cell, i| cell || i + 1 }
      .each_slice(3).map { |row| row.join(" | ") }.join("\n---------\n")
  end
end

Player = Struct.new(:name, :marker)

class Game
  def initialize
    @board = Board.new
    @players = [Player.new("Player 1", "X"), Player.new("Player 2", "O")]
  end

  def play
    puts "Tic Tac Toe — two players; enter q to quit."
    turn = 0
    loop do
      @board.display
      player = @players[turn % 2]
      print "#{player.name} (#{player.marker}), choose a cell (1–9): "
      input = $stdin.gets&.strip
      break if input.nil? || input.downcase == "q"
      unless @board.place(Integer(input, exception: false), player.marker)
        puts "Choose an empty cell from 1 to 9."
        next
      end
      if @board.winner || @board.full?
        @board.display
        puts(@board.winner ? "#{player.name} wins!" : "It's a draw!")
        break
      end
      turn += 1
    end
  end
end

Game.new.play if $PROGRAM_NAME == __FILE__
