class Board
  private

  def index_error(dir)
    raise ArgumentError, "#{dir} out of bounds"
  end

  public

  def initialize(kind = nil)
    @board = Array.new(9, ' ')
    @board = ('1'..'9').to_a if kind == :map
  end

  def row(index)
    index_error('row') unless (0..2).member? index

    @board[index * 3, 3]
  end

  def column(index)
    index_error('column') unless (0..2).member? index

    res = []
    3.times { |i| res.push(@board[index + i * 3]) }
    res
  end

  def diagonal(index)
    case index
    when 1
      [@board[0], @board[4], @board[8]]
    when 2
      [@board[2], @board[4], @board[6]]
    else
      index_error('diagonal')
    end
  end

  def available?(index)
    index_error('index') unless (0..8).member? index

    @board[index] == ' '
  end

  def update(index, token)
    index_error('index') unless (0..8).member? index

    @board[index] = token
  end

  def lines
    res = []
    3.times do |i|
      res.push(row(i))
      res.push(column(i))
    end
    res.push(diagonal(1))
    res.push(diagonal(2))
    res
  end
end
