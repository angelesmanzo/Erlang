-module(mobius).
-export([is_prime/1, prime_factors/1, is_square_multiple/1, find_duplication/2, find_square_multiples/2,test_find_square/1]).

is_prime(N) ->
is_subprime(N, trunc(math:sqrt(N))). %% trunc - усечение float

is_subprime(1, _) -> true; %% 1
is_subprime(2, _) -> true; %% 2  простое число
is_subprime(_, 1) -> true; %% делится только на 1, простое число
is_subprime(F, N) when F rem N =:= 0 -> false;
is_subprime(F, N) when F rem N =/= 0 -> is_subprime(F, N-1).

prime_factors(N) -> prime_subfactors(N, [], 2).

prime_subfactors(1, [], _) -> [1];
prime_subfactors(N, Result, N) -> Result ++ [N];
prime_subfactors(N, Result, D) when N rem D =/= 0 -> prime_subfactors(N, Result, D+1);
prime_subfactors(N, Result, D) when N rem D =:= 0 -> prime_subfactors(N div D, Result ++ [D] , 2).

is_square_multiple(N) -> find_duplication(prime_factors(N), lists:usort(prime_factors(N))).

find_duplication(X, Y) ->
    if
        X =/= Y -> true;
        true -> false
    end.

find_square_multiples(Count, MaxN) ->
find_square_submultiples(Count, 2, MaxN, 0).

find_square_submultiples(Count, CurNum, _, Count) -> CurNum - Count;
find_square_submultiples(Count, CurNum, MaxN, _) 
	when CurNum >= MaxN + Count -> fail; 
find_square_submultiples(Count, CurNum, MaxN, CurCount) ->
case is_square_multiple(CurNum) of
	true -> find_square_submultiples(Count, CurNum + 1, MaxN, CurCount + 1);
	false -> find_square_submultiples(Count, CurNum + 1, MaxN, 0)
end.

test_find_square(N) -> timer:tc(mobius,find_square_multiples, [N, 30000]).
