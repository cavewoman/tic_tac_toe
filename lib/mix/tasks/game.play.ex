defmodule Mix.Tasks.Game.Play do
  use Mix.Task

  @shortdoc "Starts a new game of Tic-Tac-Toe"

  def run(_) do
    TicTacToe.banner()
    TicTacToe.main_loop(TicTacToe.GameBoard.new, nil)
  end
end
