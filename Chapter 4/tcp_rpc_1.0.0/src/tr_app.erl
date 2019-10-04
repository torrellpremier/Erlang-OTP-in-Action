-module(tr_app).

% Behavior declaration
-behaviour(application).

% Callbacks of application behaviour
-export([start/2, stop/1]).

% Starts the root supervisor
start(_Type, _StartArgs) ->
  case tr_sup:start_link() of
    {ok, Pid} ->
      {ok, Pid};
    Other ->
      {error, Other}
  end.

stop(_State) ->
  ok.
