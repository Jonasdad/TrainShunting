defmodule Train do
  def test() do
    train = [:a, :b, :c, :d];
    train2 = [:e, :f, :g];
    append(train, train2)
    member(train, :d)
    position(train, :b, 1)

    split(append(train, train2), :c) #should return {[:a, :b], [:e, :f, :g]}
    main(train, 1) #should return {, [:a, :b], [:c, :d]}
  end

  # returns first n trains in list
  def take(_train, 0) do [] end
  def take([h|t], n) when n > 0 do
    [h | take(t, n-1)]
  end

  # Removes n wagons from front of list
  def drop(train, 0) do
    train
  end
  def drop(train, n) when n > 0 do
    [_h | t] = train
    drop(t, n-1)
  end

  # does what the name suggests
  def append([], train2) do train2 end
  def append(train1, []) do train1 end
  def append(train1, train2) do
    [h|t] = train1
    [h|append(t, train2)]
  end

  # Checks whether or not an atom is part of list
  def member([], _y) do false end
  def member(train,y) do
    [h | t] = train
    if(h == y) do
      true
    else member(t, y)
    end
  end

  # Assumes that the position is first index (1) -> if fail -> increment and iterate
  def position([], _y, _pos) do :error end
  def position(train, y, pos) do
    [h | t] = train
    if(h == y) do
      pos
    else position(t, y, pos+1)
    end
  end

  # Split at y pos into two trains (missing y in both)
  def split([y|t], y) do {[], t} end
  def split([h|t], y) do
    {t, drop} = split(t, y)
    {[h|t], drop}
  end
  # Returns a tuple of split train where n is amount of wagons attempted to be "moved"
  # but failed as no wagons left.
  def main([], n) do {n, [], []} end
  def main(train, n) do
    [h|t] = train;
    case main(t, n) do
      {0, drop, take} -> {0, [h|drop], take}
      {n, drop, take} -> {n-1, drop, [h|take]}
    end
  end

end
