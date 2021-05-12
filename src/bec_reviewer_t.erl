%%==============================================================================
%% Type definition for the default reviewer data structure
%%==============================================================================
-module(bec_reviewer_t).

%%==============================================================================
%% Exports
%%==============================================================================
-export([from_map/1, to_map/1]).

%%==============================================================================
%% Types
%%==============================================================================
-type default_reviewer() ::
    #{'from-branch' := bec_branch_t:id()
    , 'to-branch' := bec_branch_t:id()
    , 'users' := binary()
    , 'approval-required' := integer()}.

%%==============================================================================
%% Export Types
%%==============================================================================
-export_type([default_reviewer/0]).

%%==============================================================================
%% API
%%==============================================================================

%% get the list of default-reviwers referenced by id which we will use to delete
%% all reviews and re-applied later
-spec from_map(map()) -> list().
from_map(Response) ->
    jsx:decode(Response).

-spec to_map(map()) -> default_reviewer().
to_map(#{id := Id}) ->
    #{<<"id">> => Id}.

%%==============================================================================
%% Internal Functions
%%==============================================================================
-spec extract_value(list(), list()) -> list().
%% extract only required data to compare such as id in sourceRefmatcher and 
%% targetRefMatcher, and name in reviewers
%% Expected format
%% [
%%  #{<<"id">> => 123
%%  , <<"from-branch">> => <<"CBPF-**">>
%%  , <<"to-branch">> => <<"master">>
%%  , <<"users">> => [<<"user_A">>, <<"user_B">>]
%%  },
%% ...
%% ]
extract_value([], Result) -> Result.