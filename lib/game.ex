defmodule Game do
  def iteration(s) do
    cond do
      TicTacToe.game_over?(s) ->
        IO.puts("Game over. #{TicTacToe.next_player(s.player)} won")

      true -> 
        IO.gets("Next Move (player: #{s.player}): ")
        |> String.split
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple
        |> TicTacToe.play(s)
        |> print_board
        |> iteration
    end
  end

  def print_board(s) do
    for i <- 0..2 do
      for j <- 0..2 do
        " #{Map.get(s.board, {i, j}, ".")} "
      end
    end
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
    |> IO.puts
    s
  end

  def main(args \\ []) do
    IO.puts "X/O Game."
    s = TicTacToe.init
    iteration(s)
  end
end
