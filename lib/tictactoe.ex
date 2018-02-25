defmodule GameState do
  defstruct player: 'X', board: %{}
end

defmodule TicTacToe do
  def init do
    %GameState{}
  end

  def is_winning_triplet(['X', 'X', 'X']), do: true
  def is_winning_triplet(['O', 'O', 'O']), do: true
  def is_winning_triplet(_), do: false

  def has_winner?(state) do
    Enum.any?([
      [ {0, 0}, {0, 1}, {0, 2} ],
      [ {1, 0}, {1, 1}, {1, 2} ],
      [ {2, 0}, {2, 1}, {2, 2} ],
      [ {0, 0}, {1, 0}, {2, 0} ],
      [ {0, 1}, {1, 1}, {2, 1} ],
      [ {0, 2}, {1, 2}, {2, 2} ],
      [ {0, 0}, {1, 1}, {2, 2} ],
      [ {0, 2}, {1, 1}, {2, 0} ],
    ],
    fn x ->
      Map.take(state.board, x)
      |> Map.values
      |> is_winning_triplet
    end)
  end

  def game_over?(state) do
    has_winner?(state) || Map.size(state.board) == 9
  end

  def next_player('X'), do: 'O'
  def next_player('O'), do: 'X'

  def play({row, col}, state) do
    cond do
      # tried to play a finished game
      game_over?(state) ->
        state

      # square taken
      {row, col} in Map.keys(state.board) ->
        state

      # square free - take it!
      true ->
        %GameState{
          player: next_player(state.player),
          board: Map.put_new(state.board, { row, col }, state.player),
        }
    end
  end
end
