rodzic(julek, joanna).
rodzic(julek, robert).
rodzic(marcel, joanna).
rodzic(marcel, robert).
rodzic(joanna, andrzej).
rodzic(joanna, janina).
rodzic(mateusz, andrzej).
rodzic(mateusz, janina).
rodzic(robert, genowefa).
rodzic(robert, witold).
rodzic(piotrek, genowefa).
rodzic(piotrek, witold).
rodzic(maja, robert).
rodzic(maja, martyna).

rodzenstwo(X,Y) :-
    rodzic(X, Z),
    rodzic(X, W),
    rodzic(Y, Z),
    rodzic(Y, W),
    X \= Y,
    W \= Z.
kuzyn(X,Y) :-
    rodzic(X, Z),
    rodzic(Y, W),
    rodzic(Z, V),
    rodzic(W, V),
    X \= Y,
    W \= Z.
swat(X,Y) :-
    rodzic(Z,X),
    rodzic(W,Y),
    rodzic(V,Z),
    rodzic(V,W),
    X \= Y,
    W \= Z.
macocha(X,Y) :-
	rodzic(X,Z),
	rodzic(W,Z),
	rodzic(W,Y),
	\+ rodzic(X,Y),
	X \= Y.
przyrodnie(X,Y) :-
	rodzic(X,V),
	rodzic(X,W),
	rodzic(Y,W),
	rodzic(Y,Z),
	\+ rodzic(X,Z),
	\+ rodzic(Y,V),
	X \= Y,
	V \= W,
	V \= Z.
szwagier(X,Y) :-
	rodzic(Z,X),
	rodzic(Z,W),
	rodzic(W,V),
	rodzic(Y,V),
	X \= Y,
	X \= W,
	Y \= W.
wujek(X,Y) :-
	rodzic(X,Z),
	rodzic(Z,W),
	rodzic(Y,W),
	X \= Y,
	Y \= Z.
