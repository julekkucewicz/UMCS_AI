lubi(julek, romek).
lubi(romek, julek).
lubi(jan, pawel).
lubi(pawel, jan).
lubi(pawel, julita).
lubi(jan, bartek).
lubi(bartek, helena).
lubi(helena, bartek).
lubi(michalina, marcelina).
lubi(marcelina, michalina).

kobieta(julita).
kobieta(helena).
kobieta(marcelina).
kobieta(michalina).


mezczyzna(X) :- \+ kobieta(X).
przyjazn(X, Y) :- lubi(X,Y), lubi(Y,X).
niby_przyjazn(X,Y) :- lubi(X,Y); lubi(Y,X).
nieprzyjazn(X,Y) :- \+przyjazn(X,Y).
loves(X, Y) :- lubi(X, Y), \+ (lubi(X,Z), Z \= Y).
true_loves(X,Y) :- przyjazn(X,Y), \+ ((niby_przyjazn(X, Z); niby_przyjazn(Y, Z)), Z \= X, Z \= Y).
