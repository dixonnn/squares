defmodule Math do
  @moduledoc """
  Copmutation module.
  """

  @doc """
  Creates list of problems to be split between `num` workers.
  A "problem" is a series of incremental integers to be squared and summed.
  """
  def split_problem(num, [n, k]) do
    Enum.to_list(1..n + k - 1)
    |> Enum.chunk_every(k, 1, :discard)
    |> split_between_workers([], num, 0)
  end

  @doc """
  Takes a list of `problems` of the form [x, x+1, ..., y]. Each element
  in the list will be squared and summed. `split_between_workers()` groups
  up series in the list for `num` workers.
  """
  def split_between_workers(problems, list, num, count) do
    if count < num do
      # Not finished
      list = list ++ [Enum.take_every(problems, num)]
      split_between_workers(Enum.drop(problems, 1), list, num, count + 1)
    else
      # Finished, return list
      list
    end
  end

  @doc """
  Takes a starting value `x` and an consecutive array length `k`
  """
  def sum_of_squares(x, k) do
    array = x..x + k - 1
    Enum.reduce(array, 0, fn x, acc -> :math.pow(x, 2) + acc end)
    |> :erlang.trunc
  end

  @doc """
  Tests whether the integer argument is a perfect square.
  """
  def is_perfect_square(n)
    when is_integer(n) do
      :math.sqrt(n)
      |> :erlang.trunc
      |> :math.pow(2) == n
  end

  def is_perfect_square(n)
    when not is_integer(n) do
      IO.puts "Cannot determine, parameter not an integer."
  end

  @doc """
  Takes list of values and deletes all elements that are 0.
  """
  def elim_zero(list, len) when len <= 1 do
    List.delete(list, 0)
  end

  def elim_zero(list, len) do
    list = List.delete(list, 0)
    elim_zero(list, len - 1)
  end

end
