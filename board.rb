require_relative 'piece'
require 'colorize'
require 'byebug'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def perform_jump(start_pos, end_pos)
    raise 'no piece at pos' unless self[start_pos]

    piece = self[start_pos]

    if self[piece.jump_space(end_pos)].nil?
      piece.pos = end_pos
      self[piece.possible_jumped_space] = nil
      self[start_pos] = nil
      self[end_pos] = piece
    else
      false
    end
  end

  def perform_slide(start_pos, end_pos)
    raise 'no piece at pos' unless self[start_pos]

    piece = self[start_pos]

    if piece.possible_slide_moves.include?(end_pos)
      piece.pos = end_pos
      self[start_pos] = nil
      self[end_pos] = piece
    else
      false
    end
  end

  def display
    puts render
  end

  def [](pos)
    raise 'invalid pos' unless in_bounds?(pos)

    @grid[pos.first][pos.last]
  end

  def []=(pos, value)
    raise 'invalid pos' unless in_bounds?(pos)

    @grid[pos.first][pos.last] = value
  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def inspect
    display
  end

  private

    def place_pieces

      #black
      @grid[0][1] = Piece.new([0,1], :black, self)
      @grid[0][3] = Piece.new([0,1], :black, self)
      @grid[0][5] = Piece.new([0,1], :black, self)
      @grid[0][7] = Piece.new([0,1], :black, self)
      @grid[1][0] = Piece.new([0,1], :black, self)
      @grid[1][2] = Piece.new([0,1], :black, self)
      @grid[1][4] = Piece.new([0,1], :black, self)
      @grid[1][6] = Piece.new([0,1], :black, self)
      @grid[2][1] = Piece.new([0,1], :black, self)
      @grid[2][3] = Piece.new([0,1], :black, self)
      @grid[2][5] = Piece.new([0,1], :black, self)
      @grid[2][7] = Piece.new([0,1], :black, self)

      #white
      @grid[5][0] = Piece.new([0,1], :white, self)
      @grid[5][2] = Piece.new([0,1], :white, self)
      @grid[5][4] = Piece.new([0,1], :white, self)
      @grid[5][6] = Piece.new([0,1], :white, self)
      @grid[6][1] = Piece.new([0,1], :white, self)
      @grid[6][3] = Piece.new([0,1], :white, self)
      @grid[6][5] = Piece.new([0,1], :white, self)
      @grid[6][7] = Piece.new([0,1], :white, self)
      @grid[7][0] = Piece.new([0,1], :white, self)
      @grid[7][2] = Piece.new([0,1], :white, self)
      @grid[7][4] = Piece.new([0,1], :white, self)
      @grid[7][6] = Piece.new([0,1], :white, self)
    end

    def render
      background = :red
      nums = ("0".."7").to_a

      "   " + ('0'..'7').to_a.join("  ") + "\n" +
      @grid.map do |row|
        background == :red ? background = :white : background = :red

        (nums.shift + " ") + row.map do |piece|
          background == :red ? background = :white : background = :red

          if piece.nil?
            ("   ").colorize(:background => background)
          else
            (' ' + piece.render + ' ').colorize(:background => background)
          end

        end.join("")
      end.join("\n")
    end

end
