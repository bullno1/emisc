-module(em_dev).
-export([start_apps/1]).

-spec start_apps([atom()]) -> ok.
start_apps(Apps) ->
	_ = [recursive_start(App) || App <- Apps],
	ok.

recursive_start(App) ->
	recursive_start(App, permanent).

recursive_start(Application, Type) ->
	case application:start(Application, Type) of
		ok -> ok;
		{error, {not_started, Dependency}} ->
			recursive_start(Dependency, Type),
			recursive_start(Application, Type);
		{error, {already_started, _}} -> ok;
		{error, OtherReason} ->
			io:format("Error starting application ~p: ~p~n", [Application, OtherReason]),
			init:stop()
	end.
