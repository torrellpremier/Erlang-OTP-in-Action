-module(proc_comms).

-export([run/0, ping/0]).

run() ->
  Pid = spawn(fun ping/0),
  Pid ! self(),
  receive
    pong ->
      ok
  end.

ping() ->
  receive
    From ->
      From ! pong
  end.
