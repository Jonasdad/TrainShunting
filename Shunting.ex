defmodule Shunting do

  def test() do
    t1 = [:a, :b, :c, :d] #[{:one, 2}, {:two, 1}, {:one, -1}, {:two, -1}, {:one, -1}]
    t2 = [:c, :b, :d, :a]
    IO.inspect(Moves.sequence(few(t1, t2), {t1, [], []}))
    few(t1, t2)
  end

  def find([], []) do [] end
  def find(xs, [y|yt]) do
    {hs, ts} = Train.split(xs, y)
    tn = length(ts)
    hn = length(hs)
    [{:one, tn+1}, {:two, hn}, {:one, -tn-1}, {:two, -hn} | find(Train.append(hs,ts), yt)]
  end

  def few([], _) do [] end
  def few([y | xt], [y|yt]) do
    few(xt, yt)
  end
  def few(xs, [y | yt]) do
    {hs, ts} = Train.split(xs, y)
    IO.inspect({hs, ts})
    [{:one, length(ts) + 1}, {:two, length(hs)}, {:one, -length(ts) -1}, {:two, -length(hs)} | few(Train.append(hs,ts), yt)]
  end

  def compress(ms) do
    ns = rules(ms)
    if ns = ms do
      ms
    else
      compress(ns)
    end
  end
  def rules([]) do [] end
  def rules([{_, 0}| t]) do
    rules(t)
  end
  def rules([{track,n}, {track, m} | t]) do
    rules([track, n+m|t])
  end
  def rules([h|t]) do
    [h|rules(t)]
  end

end
