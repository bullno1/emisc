-module(em_time).
-export([
	current_time_ms/0,
	current_time_s/0,
	ms_to_datetime/1,
	s_to_datetime/1
]).

-spec current_time_ms() -> non_neg_integer().
current_time_ms() ->
	{MegaSec, Sec, MicroSec} = os:timestamp(),
	MegaSec * 1000000000 + Sec * 1000 + MicroSec div 1000.

-spec current_time_s() -> non_neg_integer().
current_time_s() ->
	{MegaSec, Sec, _MicroSec} = os:timestamp(),
	MegaSec * 1000000 + Sec.

-spec ms_to_datetime(non_neg_integer()) -> calendar:datetime().
ms_to_datetime(Milliseconds) ->
   BaseDate      = calendar:datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}}),
   Seconds       = BaseDate + (Milliseconds div 1000),
   calendar:gregorian_seconds_to_datetime(Seconds).

-spec s_to_datetime(non_neg_integer()) -> calendar:datetime().
s_to_datetime(Seconds) ->
   BaseDate      = calendar:datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}}),
   TargetSeconds = BaseDate + Seconds,
   calendar:gregorian_seconds_to_datetime(TargetSeconds).
