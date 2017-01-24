defmodule TicTacToe do
  use Application

  def banner do
    IO.puts("\n")
    IO.puts("TIC TAC TOE")
    IO.puts("=== === ===\n")
  end

  def main_loop({:error, _}, game_board) do
    IO.puts("Your selection was invalid, please try again.\n")
    main_loop(game_board, nil)
  end

  def main_loop(gb = %TicTacToe.GameBoard{}, _) do
    winner = TicTacToe.GameBoard.check_win(gb)
    if winner do
      IO.puts "Game over!"
      TicTacToe.GameBoard.print_board(gb)
      IO.puts "Winner: #{winner}"
    else
      TicTacToe.GameBoard.print_board(gb)
      IO.puts("It is currently #{gb.turn}'s turn.")
      raw_selection = IO.gets("Please make a selection [0-8]: ")
      main_loop(TicTacToe.GameBoard.play(gb, raw_selection), gb)
    end
  end

  def start(_type, _args) do
    Supervisor.start_link([], strategy: :one_for_one, name: TicTacToe.Supervisor)
  end
end
