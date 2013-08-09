-module(em_serialization).
-export([binary_to_term/1, term_to_binary/1,
         record_to_proplist/2, proplist_to_record/3]).

-spec binary_to_term(binary()) -> term().
binary_to_term(Bin) -> erlang:binary_to_term(Bin, [safe]).

-spec term_to_binary(term()) -> binary().
term_to_binary(Term) -> erlang:term_to_binary(Term, [compressed, {minor_version, 1}]).

-spec record_to_proplist(Record :: tuple(), RecordFields :: list(atom())) ->
	list({atom(), term()}).
record_to_proplist(Record, RecordFields) ->
	[_RecordType | RecordValues] = tuple_to_list(Record),
	lists:zip(RecordFields, RecordValues).

-spec proplist_to_record(Proplist :: list({atom(), any()}),
                         DefaultRecord :: tuple(),
                         RecordFields :: list(atom())) -> tuple().
proplist_to_record(Proplist, DefaultRecord, RecordFields) ->
	[RecordType | DefaultValues] = tuple_to_list(DefaultRecord),
	DefaultProplist = lists:zip(RecordFields, DefaultValues),
	RecordValues =
		lists:map(
			fun({FieldName, DefaultValue}) ->
				proplists:get_value(FieldName, Proplist, DefaultValue)
			end,
			DefaultProplist),
	list_to_tuple([RecordType | RecordValues]).
