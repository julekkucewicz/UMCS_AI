osoba(julek).
osoba(joanna).
osoba(robert).
osoba(andrzej).

mezczyzna(julek).
mezczyzna(robert).
mezczyzna(andrzej).

rodzic(joanna, julek).
rodzic(robert, julek).
rodzic(andrzej, joanna).

kobieta(X) :-
	osoba(X),
	\+ mezczyzna(X).
ojciec(X,Y) :-
	osoba(X),
	osoba(Y),
	rodzic(X,Y),
	mezczyzna(X).
matka(X,Y) :-
	osoba(X),
	osoba(Y),
	rodzic(X,Y),
	kobieta(X).
corka(X,Y) :-
	osoba(X),
	osoba(Y),
	rodzic(Y,X),
	kobieta(X).
brat_rodzony(X,Y) :-
	osoba(X),
	osoba(Y),
	ojciec(X,Z),
	ojciec(Y,Z),
	matka(X,W),
	matka(Y,W),
	mezczyzna(X).
brat_przyrodni(X,Y) :-
	osoba(X),
	osoba(Y),
		((ojciec(X,Z),
		ojciec(Y,Z),
		matka(X,W),
		matka(X,V),
		W \= V);
    
		(matka(X,Z),
		matka(Y,Z),
		ojciec(X,W),
		ojciec(X,V),
		W \= V)).	
kuzyn(X,Y) :-
    rodzic(Z, X),
    rodzic(W, Y),
    rodzic(V, Z),
    rodzic(V, Z),
    mezczyzna(X),
    X \= Y,
    W \= Z.
dziadek_od_strony_ojca(X,Y) :-
	ojciec(Z,Y),
	ojciec(X,Z).
dziadek_od_strony_matki(X,Y) :-
	matka(Z,Y),
	ojciec(X,Z).
dziadek(X,Y) :-
	dziadek_od_strony_ojca(X,Y);
	dziadek_od_strony_matki(X,Y).
babcia(X,Y) :-
	(ojciec(Z,Y),
	matka(X,Z));
	(matka(Z,Y),
	matka(X,Z)).
wnuczka(X,Y) :-
	babcia(X,Y),
	kobieta(Y).
przodek_do2pokolenia_wstecz(X,Y) :-
	rodzic(Y,X);
	dziadek(Y,X);
	babcia(Y,X).
przodek_do3pokolenia_wstecz(X,Y) :-
	przodek_do2pokolenia_wstecz(X,Y);
	dziadek(Z,X),rodzic(Y,Z);
	babcia(Z,X),rodzic(Y,Z).
