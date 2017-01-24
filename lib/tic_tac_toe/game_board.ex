defmodule TicTacToe.GameBoard do
  defstruct spaces: %{
      0 => nil, 1 => nil, 2 => nil,
      3 => nil, 4 => nil, 5 => nil,
      6 => nil, 7 => nil, 8 => nil
    }, turn: :x

  # Exercise 3 look here!
  @win_conditions [
    [0, 1, 2], # 0
    [3, 4, 5], # 1
    [6, 7, 8], # 2
    [0, 3, 6], # 3
    [1, 4, 7], # 4
    [2, 5, 8], # 5
    [0, 4, 8], # 6
    [2, 4, 6]  # 7
  ]

  def new do
    %TicTacToe.GameBoard{}
  end

  defmacro is_valid_selection(sel) do
    quote do: is_integer(unquote(sel)) and 0 <= unquote(sel) and unquote(sel) <= 8
  end

  def next_turn(:x), do: :o
  def next_turn(:o), do: :x

  def play(gb = %TicTacToe.GameBoard{}, selection) when is_valid_selection(selection) do
    %{gb | spaces: Map.put(gb.spaces, selection, gb.turn), turn: next_turn(gb.turn)}
  end

  def play(gb = %TicTacToe.GameBoard{}, selection) when is_binary(selection) do
    int_selection = selection
      |> String.trim
      |> String.to_integer

    play(gb, int_selection)
  end

  def play(_, _) do
    {:error, :invalid_selection}
  end

  ##
  # Begin exercise 1
  ##
  def chunk_rows(game_board_spaces) do
    # YOUR CODE GOES HERE
  end
  ##
  # End exercise 1
  ##

  ##
  # Begin exercise 2
  ##
  def space_to_str({_, :x}), do: " X "
  def space_to_str({_, :o}), do: " O "
  def space_to_str({_, nil}), do: "   "

  def row_to_str(row) do
    # YOUR CODE GOES HERE
  end
  ##
  # End exercise 2
  ##

  def print_board(gb = %TicTacToe.GameBoard{}) do
    gb.spaces
      |> chunk_rows
      |> Enum.map(&row_to_str/1)
      |> Enum.join("\n---|---|---\n")
      |> IO.puts

    IO.puts ""
  end

  ##
  # Begin exercise 3
  ##
  def pluck_spaces(gb = %TicTacToe.GameBoard{}, indices) do
    Enum.map(indices, fn(x) -> Map.get(gb.spaces, x) end)
  end

  def variant_has_winner?(gb = %TicTacToe.GameBoard{}, indices) do
    case pluck_spaces(gb, indices) do
      [:x, :x, :x] ->
        :x
      [:o, :o, :o] ->
        :o
      _ ->
        false
    end
  end

  def fetch_win_variants(gb = %TicTacToe.GameBoard{}) do
    # YOUR CODE GOES HERE
  end
  ##
  # End exercise 3
  ##

  ##
  # Begin exercise 4
  ##
  def check_win(gb = %TicTacToe.GameBoard{}) do
    # YOUR CODE GOES HERE
  end
  ##
  # End exercise 4
  ##
end
