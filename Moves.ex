defmodule Moves do
  def test() do
    #single({:one, 1}, {[:a,:b], [:c],[]})
    sequence([{:one, 1}, {:two, 1}, {:one, -1}, {:two, -1}], {[:a,:b], [], []})
  end


  def single({_, 0}, state) do state end
  def single({:one, n}, {main, one, two}) when n > 0 do
    {0, rem, wagons} = Train.main(main, n)
    {rem, Train.append(wagons, one), two}
  end
  def single({:one, n}, {main, one, two}) when n < 0 do
    wagons = Train.take(one, -n)
    {Train.append(main, wagons), Train.drop(one, -n), two}
  end

  def single({:two, n}, {main, one, two}) when n > 0 do
    {0, rem, wagons} = Train.main(main, n)
    {rem, one, Train.append(wagons, two)}
  end
  def single({:two, n}, {main, one, two}) when n < 0 do
    wagons = Train.take(two, -n)
    {Train.append(main, wagons), one, Train.drop(two, -n)}
  end

  def sequence([], state) do [state] end
  def sequence(moves, state) do
    [h|t] = moves;
    [state | sequence(t, single(h, state))]
  end
end
