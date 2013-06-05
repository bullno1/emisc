-module(em_serialization).
-export([binary_to_term/1, term_to_binary/1]).

-spec binary_to_term(binary()) -> term().
binary_to_term(Bin) -> erlang:binary_to_term(Bin, [safe]).

-spec term_to_binary(term()) -> binary().
term_to_binary(Term) -> erlang:term_to_binary(Term, [compressed, {minor_version, 1}]).
