defmodule TicTacToe.GameBoardTest do
  use ExUnit.Case

  @tag important: "ex1"
  test "can split board spaces into three-space chunks" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => :x, 1 => :o, 2 => :x,
        3 => :o, 4 => :x, 5 => :o,
        6 => :o, 7 => :o, 8 => nil
      }
    }
    chunked_rows = [
      [{0, :x}, {1, :o}, {2, :x}],
      [{3, :o}, {4, :x}, {5, :o}],
      [{6, :o}, {7, :o}, {8, nil}]
    ]
    assert TicTacToe.GameBoard.chunk_rows(game_board.spaces) == chunked_rows
  end

  @tag important: "ex2"
  test "rows convert to strings properly" do
    assert TicTacToe.GameBoard.row_to_str([{0, :x}, {1, :o}, {2, :x}]) == " X | O | X "
    assert TicTacToe.GameBoard.row_to_str([{3, :o}, {4, :x}, {5, :o}]) == " O | X | O "
    assert TicTacToe.GameBoard.row_to_str([{6, :o}, {7, :o}, {8, nil}]) == " O | O |   "
  end

  @tag important: "ex3"
  test "new board does not satisfy any win conditions" do
    game_board = TicTacToe.GameBoard.new
    assert TicTacToe.GameBoard.fetch_win_variants(game_board) == [false, false, false, false, false, false, false, false]
  end

  @tag important: "ex3"
  test "x wins, variant 5" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => nil, 1 => nil, 2 => :x,
        3 => nil, 4 => nil, 5 => :x,
        6 => nil, 7 => nil, 8 => :x
      }
    }
    assert TicTacToe.GameBoard.fetch_win_variants(game_board) == [false, false, false, false, false, :x, false, false]
  end

  @tag important: "ex3"
  test "o wins, variant 6" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => :o,  1 => nil, 2 => nil,
        3 => nil, 4 => :o,  5 => nil,
        6 => nil, 7 => nil, 8 => :o
      }
    }
    assert TicTacToe.GameBoard.fetch_win_variants(game_board) == [false, false, false, false, false, false, :o, false]
  end

  @tag important: "ex4"
  test "can detect row wins" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => :o,  1 => :o,  2 => :o,
        3 => nil, 4 => nil, 5 => nil,
        6 => nil, 7 => nil, 8 => nil
      }
    }
    assert TicTacToe.GameBoard.check_win(game_board) == :o
  end

  @tag important: "ex4"
  test "can detect column wins" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => nil, 1 => nil, 2 => :x,
        3 => nil, 4 => nil, 5 => :x,
        6 => nil, 7 => nil, 8 => :x
      }
    }
    assert TicTacToe.GameBoard.check_win(game_board) == :x
  end

  @tag important: "ex4"
  test "can detect diagonal wins" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => :o,  1 => nil, 2 => nil,
        3 => nil, 4 => :o,  5 => nil,
        6 => nil, 7 => nil, 8 => :o
      }
    }
    assert TicTacToe.GameBoard.check_win(game_board) == :o
  end

  test "games start with player x" do
    game_board = TicTacToe.GameBoard.new
    assert game_board.turn == :x
  end

  test "after x plays, it becomes player y's turn" do
    game_board = TicTacToe.GameBoard.new
      |> TicTacToe.GameBoard.play(4)
    assert game_board.turn == :o
  end

  test "after y plays, it becomes player x's turn" do
    game_board = TicTacToe.GameBoard.new
      |> TicTacToe.GameBoard.play(4)
      |> TicTacToe.GameBoard.play(5)
    assert game_board.turn == :x
  end

  test "cannot make invalid selections" do
    game_board = TicTacToe.GameBoard.new
    assert TicTacToe.GameBoard.play(game_board, 99) == {:error, :invalid_selection}
    assert TicTacToe.GameBoard.play(game_board, 9) == {:error, :invalid_selection}
    assert TicTacToe.GameBoard.play(game_board, -1) == {:error, :invalid_selection}
  end

  test "can make string selections" do
    game_board = TicTacToe.GameBoard.new
    refute TicTacToe.GameBoard.play(game_board, "5") == {:error, :invalid_selection}
  end

  test "can pluck board spaces" do
    game_board = %TicTacToe.GameBoard{
      spaces: %{
        0 => :x, 1 => :o, 2 => :x,
        3 => :o, 4 => :x, 5 => :o,
        6 => :o, 7 => :o, 8 => nil
      }
    }
    assert TicTacToe.GameBoard.pluck_spaces(game_board, [0, 1, 2]) == [:x, :o, :x]
    assert TicTacToe.GameBoard.pluck_spaces(game_board, [0, 4, 8]) == [:x, :x, nil]
    assert TicTacToe.GameBoard.pluck_spaces(game_board, [2, 4, 6]) == [:x, :x, :o]
    assert TicTacToe.GameBoard.pluck_spaces(game_board, [2, 5, 8]) == [:x, :o, nil]
  end
end
