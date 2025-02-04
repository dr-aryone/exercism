defmodule ListOps do

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn(_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reduce(l, [], fn(el, acc) -> [el | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    reduce(reverse(l), [], fn(el, acc) -> [f.(el) | acc] end)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reduce(reverse(l), [], fn(el, acc) -> if f.(el) == true do [el | acc] else acc end end)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  def reduce([], acc, _f) do
    acc
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reduce(reverse(a), b, fn(el, acc) -> [el | acc] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(reverse(ll), [], fn(el, acc) -> append(el, acc) end)
  end
end
