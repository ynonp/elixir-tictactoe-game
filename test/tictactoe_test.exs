defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test 'board starts empty' do
    s = TicTacToe.init
    assert map_size(s.board) == 0
  end

  test 'X plays first' do
    s = TicTacToe.init
    assert s.player == 'X'
  end

  test 'winning row is detected' do
    board = %{ {0, 0} => 'X', {0, 1} => 'X', { 0, 2 } => 'X' }
    s = %GameState{board: board, player: 'O'}
    assert TicTacToe.has_winner?(s)
  end

  test 'winning column is detected' do
    board = %{ {0, 0} => 'X', {1, 0} => 'X', { 2, 0 } => 'X' }
    s = %GameState{board: board, player: 'O'}
    assert TicTacToe.has_winner?(s)
  end

  test 'O can win too' do
    board = %{ {0, 0} => 'O', {1, 0} => 'O', { 2, 0 } => 'O' }
    s = %GameState{board: board, player: 'O'}
    assert TicTacToe.has_winner?(s)
  end

  test 'XOX is not a win' do
    board = %{ {0, 0} => 'X', {1, 0} => 'O', { 2, 0 } => 'X' }
    s = %GameState{board: board, player: 'O'}
    refute TicTacToe.has_winner?(s)
  end

  test 'State does not change when playing a finished board' do
    board = %{ {0, 0} => 'X', {1, 0} => 'X', { 2, 0 } => 'X' }
    s = %GameState{board: board, player: 'O'}
    assert TicTacToe.play({1, 1}, s) == s
  end

  test 'State does not change when playing a taken square' do
    board = %{ {0, 0} => 'X' }
    s = %GameState{board: board, player: 'O'}
    assert TicTacToe.play({0, 0}, s) == s
  end
end
