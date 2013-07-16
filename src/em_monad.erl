-module(em_monad).
-export([do/3]).
-export_type([bind_fun/2, unit_fun/2]).

-type bind_fun(T, MonadT) :: fun((MonadT, unit_fun(T, MonadT)) -> MonadT).
-type unit_fun(T, MonadT) :: fun((T) -> MonadT).

-spec do(BindFun, UnitFuns, Acc) -> Result when
	BindFun  :: bind_fun(T, MonadT),
	UnitFuns :: list(unit_fun(T, MonadT)),
	Acc      :: T,
	Result   :: T.
do(_BindFun, [], Acc) -> Acc;
do(BindFun, [UnitFun | Rest], Acc) ->
	do(BindFun, Rest, BindFun(Acc, UnitFun)).
