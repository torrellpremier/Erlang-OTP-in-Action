-module(currency_converter).

-export([start/1, stop/1, accumulator/2]).

start(Currency) ->
  spawn(currency_converter, accumulator, [0, Currency]).

stop(Pid) ->
  Pid ! {stop, self()},
  receive
    {ok, Result} ->
      Result
    after 1000 ->
      {error, timeout}
  end.

% Converts from huf to gbp
accumulator(Total, huf) ->
  receive
    {add, Value} ->
      UpdatedTotal = Total + huf_to_gbp(Value),
      accumulator(UpdatedTotal, huf);
    {subtract, Value} ->
      UpdatedTotal = Total - huf_to_gbp(Value),
      accumulator(UpdatedTotal, huf);
    {stop, Pid} ->
      Pid ! {ok, Total},
      ok
  end.

huf_to_gbp(Value) ->
  Value * 0.0027.
