;  ---------------------------------------------
;  --- Definizione del modulo e dei template ---
;  ---------------------------------------------
(defmodule AGENT (import MAIN ?ALL) (import ENV ?ALL) (export ?ALL))


;NOTA: le celle inizialmente conosciute (k-cell) vengono considerate nel calcolo dei sink

(deftemplate deduced-cell 
	(slot x)
	(slot y)
	(slot content (allowed-values water left right middle top bot sub))
)

;(defrule print-what-i-know-new
;	(declare (salience 10))
;	(k-cell (x ?x) (y ?y) (content ?t) )
;=>
;	(printout t "I know that cell [" ?x ", " ?y "] contains " ?t "." crlf)
;)

(defrule translate_k-cell
	(declare (salience 10))
	(k-cell (x ?x) (y ?y) (content ?t) )
=>
	(printout t "I deduced that cell [" ?x ", " ?y "] contains " ?t "." crlf)
	(assert (deduced-cell (x ?x) (y ?y) (content ?t) ))
)

;se so che ci sono navi per le quali conosco left e right (o top e bot) separate da una casella, posso fare guess su quella casella middle----------

(defrule fire_middle_horizontal
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	
	(deduced-cell (x ?x1) (y ?y1) (content left))
	(deduced-cell (x ?x3&:(eq ?x3 ?x1)) (y ?y3&:(eq ?y3 (+ 2 ?y1))) (content right))
	(not (exec  (action guess) (x ?x1) (y ?y&:(eq ?y (+ ?y1 1)))))
	(not (exec  (action fire) (x ?x1) (y ?y&:(eq ?y (+ ?y1 1)))))
	(not (deduced-cell (x ?x1) (y ?y&:(eq ?y (+ ?y1 1)))))
	(not (deduced-cell (x ?x1) (y ?y&:(eq ?y (+ ?y1 1)))))
=>
	(bind ?newy (+ ?y1 1))
	;(printout t "Guess on cell [" ?x1 ", " ?newy "]!" crlf)
	(printout t "[FIRE]--" ?x1 "|" ?newy crlf)
	(assert (exec (step ?s) (action fire) (x ?x1) (y ?newy)))
	;(assert (deduced-cell (x ?x1) (y ?newy) (content middle)))
	(pop-focus)
)

(defrule fire_middle_vertical
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content top))
	(deduced-cell (x ?x3&:(eq ?x3 (+ 2 ?x1))) (y ?y1) (content bot))
	(not (exec  (action guess) (x ?x&:(eq ?x (+ 1 ?x1))) (y ?y1)))
	(not (exec  (action fire) (x ?x&:(eq ?x (+ 1 ?x1))) (y ?y1))) ;perchè potrebbero essere top e bot di due navi diverse
	
	(not (k-cell (x ?x&:(eq ?x (+ 1 ?x1))) (y ?y1)))
	(not (deduced-cell (x ?x&:(eq ?x (+ 1 ?x1))) (y ?y1)))
=>
	(bind ?newx (+ ?x1 1))
	;(printout t "Guess on cell [" ?newx ", " ?y1 "]!" crlf)
	(printout t "[FIRE]--" ?newx "|" ?y1 crlf)
	(assert (exec (step ?s) (action fire) (x ?newx) (y ?y1)))
	;(assert (deduced-cell (x ?newx) (y ?y1) (content middle)))
	(pop-focus)
)

;----------------------------------------------------------------

;se conosco due middle posso fare guess su top/bot o su left/right (la corazzata)
(defrule fire_middle_middle_horiz1
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content middle));so che x1,y1 è middle
	(deduced-cell (x ?x1) (y ?y3&:(eq ?y3 (+ 1 ?y1))) (content middle));so che x1,y1+1 è middle
	(not (exec  (action guess) (x ?x1) (y ?y4&:(eq ?y4 (+ 2 ?y1)))));non è stata fatta guess su x1,y1+2
	(not (exec  (action fire) (x ?x1) (y ?y4&:(eq ?y4 (+ 2 ?y1)))));non è stata fatta fire su x1,y1+2
	
	(not (k-cell (x ?x1) (y ?y&:(eq ?y (+ ?y1 2)))));non conosco il contenuto di x1,y1+2
	(not (deduced-cell (x ?x1) (y ?y&:(eq ?y (+ ?y1 2)))));non conosco il contenuto di x1,y1+2
=>
	(bind ?yright (+ ?y1 2))
	(printout t "[FIRE]--" ?x1 "|" ?yright crlf)
	(assert (exec (step ?s) (action fire) (x ?x1) (y ?yright)))
	;(assert (deduced-cell (x ?x1) (y ?yright) (content right)))
	(pop-focus)
)

(defrule fire_middle_middle_horiz2
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content middle));so che x1,y1 è middle
	(deduced-cell (x ?x1) (y ?y3&:(eq ?y3 (+ 1 ?y1))) (content middle));so che x1,y1+1 è middle
	(not (exec  (action guess) (x ?x1) (y ?y5&:(eq ?y5 (- ?y1 1)))));non è stata fatta guess su x1,y1-1
	(not (exec  (action fire) (x ?x1) (y ?y5&:(eq ?y5 (- ?y1 1)))));non è stata fatta fire su x1,y1-1
	
	(not (k-cell (x ?x1) (y ?y&:(eq ?y (- ?y1 1)))));non conosco il contenuto di x1,y1-1
	(not (deduced-cell (x ?x1) (y ?y&:(eq ?y (- ?y1 1)))));non conosco il contenuto di x1,y1-1
=>
	(bind ?yleft (- ?y1 1))
	(printout t "[FIRE]--" ?x1 "|" ?yleft crlf)
	(assert (exec (step ?s) (action fire) (x ?x1) (y ?yleft)))
	;(assert (deduced-cell (x ?x1) (y ?yleft) (content left)))
	(pop-focus)
)


(defrule fire_middle_middle_vertical1
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content middle));so che x1,y1 è middle
	(deduced-cell (x ?x3&:(eq ?x3 (+ 1 ?x1))) (y ?y1) (content middle));so che x1+1,y1 è middle
	(not (exec  (action guess) (x ?x4&:(eq ?x4 (- ?x1 1))) (y ?y1)));non è stata fatta guess su x1-1,y1
	(not (exec  (action fire) (x ?x4&:(eq ?x4 (- ?x1 1))) (y ?y1)));non è stata fatta fire su x1-1,y1

	(not (k-cell (x ?x4&:(eq ?x4 (- ?x1 1))) (y ?y1)));non conosco il contenuto di x1-1,y1
	(not (deduced-cell (x ?x4&:(eq ?x4 (- ?x1 1))) (y ?y1)));non conosco il contenuto di x1-1,y1
=>
	(bind ?xtop (- ?x1 1))
	(printout t "[FIRE]--" ?xtop "|" ?y1 crlf)
	(assert (exec (step ?s) (action fire) (x ?xtop) (y ?y1)))
	;(assert (deduced-cell (x ?xtop) (y ?y1) (content top)))
	(pop-focus)
)

(defrule fire_middle_middle_vertical2
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content middle));so che x1,y1 è middle
	(deduced-cell (x ?x3&:(eq ?x3 (+ 1 ?x1))) (y ?y1) (content middle));so che x1+1,y1 è middle
	(not (exec  (action guess) (x ?x4&:(eq ?x4 (+ ?x1 2))) (y ?y1)));non è stata fatta guess su x1+2,y1
	(not (exec  (action fire) (x ?x4&:(eq ?x4 (+ ?x1 2))) (y ?y1)));non è stata fatta fire su x1+2,y1
	
	(not (k-cell (x ?x4&:(eq ?x4 (+ ?x1 2))) (y ?y1)));non conosco il contenuto di x1+2,y1
	(not (deduced-cell (x ?x4&:(eq ?x4 (+ ?x1 2))) (y ?y1)));non conosco il contenuto di x1+2,y1
=>
	(bind ?xbot (+ ?x1 2))
	(printout t "[FIRE]--" ?xbot "|" ?y1 crlf)
	(assert (exec (step ?s) (action fire) (x ?xbot) (y ?y1)))
	;(assert (deduced-cell (x ?xbot) (y ?y1) (content bot)))
	(pop-focus)
)

;se so che ci sono navi per le quali conosco left e middle, posso fare guess su right. E anche viceversa con right e middle e bottom e up----------
(defrule fire_middle_left
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content left))
	(deduced-cell (x ?x3&:(eq ?x3 ?x1)) (y ?y3&:(eq ?y3 (+ 1 ?y1))) (content middle))
	(not (exec  (action guess) (x ?x&:(eq ?x ?x1)) (y ?y&:(eq ?y (+ ?y1 2)))))
	(not (exec  (action fire) (x ?x&:(eq ?x ?x1)) (y ?y&:(eq ?y (+ ?y1 2)))))

	(not (k-cell (x ?x1) (y ?y&:(eq ?y (+ ?y1 2)))))
	(not (deduced-cell (x ?x1) (y ?y&:(eq ?y (+ ?y1 2)))))
=>
	(bind ?newy (+ ?y1 2))
	;(printout t "Guess on cell [" ?x1 ", " ?newy "]!" crlf)
	(printout t "[FIRE]--" ?x1 "|" ?newy crlf)
	(assert (exec (step ?s) (action fire) (x ?x1) (y ?newy)))
	;(assert (deduced-cell (x ?x1) (y ?newy) (content right)));potrebbe anche essere middle ma comunque c'è qualcosa
	(pop-focus)
)

(defrule fire_middle_right
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content right))
	(deduced-cell (x ?x3&:(eq ?x3 ?x1)) (y ?y3&:(eq ?y3 (- ?y1 1 ))) (content middle))
	(not (exec  (action guess) (x ?x&:(eq ?x ?x1)) (y ?y&:(eq ?y (- ?y1 2)))))
	(not (exec  (action fire) (x ?x&:(eq ?x ?x1)) (y ?y&:(eq ?y (- ?y1 2)))))
	
	(not (k-cell (x ?x1) (y ?y&:(eq ?y (- ?y1 2)))))
	(not (deduced-cell (x ?x1) (y ?y&:(eq ?y (- ?y1 2)))))
=>
	(bind ?newy (- ?y1 2))
	;(printout t "Guess on cell [" ?x1 ", " ?newy "]!" crlf)
	(printout t "[FIRE]--" ?x1 "|" ?newy crlf)
	(assert (exec (step ?s) (action fire) (x ?x1) (y ?newy)))
	;(assert (deduced-cell (x ?x1) (y ?newy) (content left)));potrebbe anche essere middle ma comunque c'è qualcosa
	(pop-focus)
)

(defrule fire_middle_top
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content top))
	(deduced-cell (x ?x3&:(eq ?x3 (+ 1 ?x1))) (y ?y3&:(eq ?y3 ?y1)) (content middle))
	(not (exec  (action guess) (x ?x&:(eq ?x (+ 2 ?x1))) (y ?y&:(eq ?y ?y1))))
	(not (exec  (action fire) (x ?x&:(eq ?x (+ 2 ?x1))) (y ?y&:(eq ?y ?y1))))
	
	(not (k-cell (x ?x&:(eq ?x (+ 2 ?x1))) (y ?y1)))
	(not (deduced-cell (x ?x&:(eq ?x (+ 2 ?x1))) (y ?y1)))
=>
	(bind ?newx (+ ?x1 2))
	;(printout t "Guess on cell [" ?newx ", " ?y1 "]!" crlf)
	(printout t "[FIRE]--" ?newx "|" ?y1 crlf)
	(assert (exec (step ?s) (action fire) (x ?newx) (y ?y1)))
	;(assert (deduced-cell (x ?newx) (y ?y1) (content bot)));potrebbe anche essere middle ma comunque c'è qualcosa
	(pop-focus)
)

(defrule fire_middle_bottom
	(status (step ?s)(currently running))
	(moves (guesses ?ng &:(> ?ng 0)))
	(deduced-cell (x ?x1) (y ?y1) (content bot))
	(deduced-cell (x ?x3&:(eq ?x3 (- ?x1 1))) (y ?y3&:(eq ?y3 ?y1)) (content middle))
	(not (exec  (action guess) (x ?x&:(eq ?x (- ?x1 2))) (y ?y&:(eq ?y ?y1))))
	(not (exec  (action fire) (x ?x&:(eq ?x (- ?x1 2))) (y ?y&:(eq ?y ?y1))))
	
	(not (k-cell (x ?x&:(eq ?x (- ?x1 2))) (y ?y1)))
	(not (deduced-cell (x ?x&:(eq ?x (- ?x1 2))) (y ?y1)))
=>
	(bind ?newx (- ?x1 2))
	;(printout t "Guess on cell [" ?newx ", " ?y1 "]!" crlf)
	(printout t "[FIRE]--" ?newx "|" ?y1 crlf)
	(assert (exec (step ?s) (action fire) (x ?newx) (y ?y1)))
	;(assert (deduced-cell (x ?newx) (y ?y1) (content top)));potrebbe anche essere middle ma comunque c'è qualcosa
	(pop-focus)
)




;--------------------------------


;UNGUESS RULES ----------------------------------------------------------------------------------------
(defrule unguess_for_middle_horizontal
	(status (step ?s)(currently running))
	(exec (action guess) (x ?x) (y ?y));è stata eseguita una guess sulla cella 
	?cell <- (deduced-cell(x ?x) (y ?y) (content ?c&:(neq ?c middle)));la cella è guessed != middle
	(deduced-cell(x ?x1&:(eq ?x1 (- ?x 1))) (y ?y) (content ?sup&:(eq ?sup top)));la cella sopra è top
	(or
		(deduced-cell(x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y) (content ?down&:(eq ?down middle)));la cella sotto è middle o bot
		(deduced-cell(x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y) (content ?down&:(eq ?down bot)));la cella sotto è middle o bot
	)
=>
	(retract ?cell);retract deduced-cell
	(printout t "[UNGUESS]--" ?x "|" ?y crlf)
	(assert (exec (step ?s) (action unguess) (x ?x) (y ?y)));assert unguess
	(pop-focus)
)

(defrule unguess_for_middle_vertical
	(status (step ?s)(currently running))
	(exec (action guess) (x ?x) (y ?y));è stata eseguita una guess sulla cella 
	?cell <- (deduced-cell(x ?x) (y ?y) (content ?c&:(neq ?c middle)));la cella è guessed != middle
	(deduced-cell(x ?x) (y ?y1&:(eq ?y1 (+ ?y 1))) (content ?right&:(eq ?right right)));la cella a destra è right
	(or
		(deduced-cell(x ?x) (y ?y1&:(eq ?y1 (+ ?y 1))) (content ?left&:(eq ?left left)));;la cella a sinistra è left o middle
		(deduced-cell(x ?x) (y ?y1&:(eq ?y1 (+ ?y 1))) (content ?left&:(eq ?left middle)));;la cella a sinistra è left o middle
	)
=>
	(retract ?cell);retract deduced-cell
	(printout t "[UNGUESS]--" ?x "|" ?y crlf)
	(assert (exec (step ?s) (action unguess) (x ?x) (y ?y)));assert unguess
	(pop-focus)
)

;GUESS RULES ----------------------------------------------------------------------------------------

;guess sulla cella sotto quella top
(defrule guess-under-top
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	(deduced-cell (x ?x) (y ?y) (content top));so che la cella ha contenuto top
	
	(not (k-cell (x ?x1&:(eq ?x1 (+ 1 ?x))) (y ?y)));non conosco il contenuto della cella sotto
	(not (deduced-cell (x ?x1&:(eq ?x1 (+ 1 ?x))) (y ?y)));non conosco il contenuto della cella sotto
	(not (exec  (action guess) (x ?x1&:(eq ?x1 (+ 1 ?x))) (y ?y))); so che non sono state fatte guess su quella sotto
	(not (exec  (action fire) (x ?x1&:(eq ?x1 (+ 1 ?x))) (y ?y))); so che non sono state fatte fire su quella sotto
	(exists
		(or 
			(and
				(not (k-cell (x ?x2&:(eq ?x2 (+ 2 ?x))) (y ?y))); non conosco il valore di quella due volte sotto oppure lo conosco ma è uguale a water
				(not (deduced-cell (x ?x2&:(eq ?x2 (+ 2 ?x))) (y ?y))); non conosco il valore di quella due volte sotto oppure lo conosco ma è uguale a water
			)
			(k-cell (x ?x2&:(eq ?x2 (+ 2 ?x))) (y ?y) (content water))
			(deduced-cell(x ?x2&:(eq ?x2 (+ 2 ?x))) (y ?y) (content water))
			
		)
	)
=>
	(bind ?newx (+ ?x 1))
	;(printout t "Fire on cell [" ?newx ", " ?y "]!" crlf)
	(printout t "[GUESS]--" ?newx "|" ?y crlf)
	(assert (exec (step ?s) (action guess) (x ?newx) (y ?y)))
	(assert (deduced-cell (x ?newx) (y ?y) (content bot)));potrebbe anche essere middle
	(pop-focus)
)

;guess sulla cella sopra quella bottom
(defrule guess-over-bottom
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	(deduced-cell (x ?x) (y ?y) (content bot));so che la cella ha contenuto bot
	
	(not (k-cell (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y)));non conosco il contenuto della cella sopra
	(not (deduced-cell (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y)));non conosco il contenuto della cella sopra
	(not (exec  (action guess) (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y))); so che non sono state fatte guess su quella sopra
	(not (exec  (action fire) (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y))); so che non sono state fatte fire su quella sopra
	(exists
		(or 
			(and
				(not (k-cell (x ?x2&:(eq ?x2 (- ?x 2))) (y ?y))); non conosco il valore di quella due volte sopra oppure lo conosco ma è uguale a water
				(not (deduced-cell (x ?x2&:(eq ?x2 (- ?x 2))) (y ?y))); non conosco il valore di quella due volte sopra oppure lo conosco ma è uguale a water
			)
			(k-cell (x ?x2&:(eq ?x2 (- ?x 2))) (y ?y) (content water))
			(deduced-cell (x ?x2&:(eq ?x2 (- ?x 2))) (y ?y) (content water))
	
		)
	)
=>
	(bind ?newx (- ?x 1))
	;(printout t "Fire on cell [" ?newx ", " ?y "]!" crlf)
	(printout t "[GUESS]--" ?newx "|" ?y crlf)
	(assert (exec (step ?s) (action guess) (x ?newx) (y ?y)))
	(assert (deduced-cell (x ?newx) (y ?y) (content top)));potrebbe anche essere middle
	(pop-focus)
)


;guess sulla cella a destra di left
(defrule guess-right-left
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	(deduced-cell (x ?x) (y ?y) (content left));so che la cella ha contenuto left
	(not (k-cell (x ?x) (y ?y1&:(eq ?y1 (+ 1 ?y)))));non conosco il contenuto della cella a destra
	(not (deduced-cell (x ?x) (y ?y1&:(eq ?y1 (+ 1 ?y)))));non conosco il contenuto della cella a destra
	(not (exec  (action guess) (x ?x) (y ?y1&:(eq ?y1 (+ 1 ?y))))); so che non sono state fatte guess su quella a destra
	(not (exec  (action fire) (x ?x) (y ?y1&:(eq ?y1 (+ 1 ?y))))); so che non sono state fatte fire su quella a destra
	(exists
		(or 
			(and
				(not (k-cell (x ?x) (y ?y2&:(eq ?y2 (+ 2 ?y))))); non conosco il valore di quella due volte a destra oppure lo conosco ma è uguale a water
				(not (deduced-cell (x ?x) (y ?y2&:(eq ?y2 (+ 2 ?y))))); non conosco il valore di quella due volte a destra oppure lo conosco ma è uguale a water
			)
			
			(k-cell (x ?x) (y ?y2&:(eq ?y2 (+ 2 ?y))) (content water))
			(deduced-cell (x ?x) (y ?y2&:(eq ?y2 (+ 2 ?y))) (content water))
		)
	)
=>
	(bind ?newy (+ ?y 1))
	;(printout t "Fire on cell [" ?x ", " ?newy "]!" crlf)
	(printout t "[GUESS]--" ?x "|" ?newy crlf)
	(assert (exec (step ?s) (action guess) (x ?x) (y ?newy)))
	(assert (deduced-cell (x ?x) (y ?newy) (content right)));potrebbe anche essere middle
	(pop-focus)
)


;guess sulla cella a sinistra di right
(defrule guess-left-right
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	(deduced-cell (x ?x) (y ?y) (content right));so che la cella ha contenuto right
	
	(not (k-cell (x ?x) (y ?y1&:(eq ?y1 (- ?y 1)))));non conosco il contenuto della cella a sinistra
	(not (deduced-cell (x ?x) (y ?y1&:(eq ?y1 (- ?y 1)))));non conosco il contenuto della cella a sinistra
	(not (exec  (action guess) (x ?x) (y ?y1&:(eq ?y1 (- ?y 1))))); so che non sono state fatte guess su quella a sinistra
	(not (exec  (action fire) (x ?x) (y ?y1&:(eq ?y1 (- ?y 1))))); so che non sono state fatte fire su quella a sinistra
	(exists
		(or 
			(and
				(not (k-cell (x ?x) (y ?y2&:(eq ?y2 (- ?y 2))))); non conosco il valore di quella due volte a sinistra oppure lo conosco ma è uguale a water
				(not (deduced-cell (x ?x) (y ?y2&:(eq ?y2 (- ?y 2))))); non conosco il valore di quella due volte a sinistra oppure lo conosco ma è uguale a water
			)
			
			(k-cell (x ?x) (y ?y2&:(eq ?y2 (- ?y 2))) (content water))
			(deduced-cell (x ?x) (y ?y2&:(eq ?y2 (- ?y 2))) (content water))
		)
	)
=>
	(bind ?newy (- ?y 1))
	;(printout t "Fire on cell [" ?x ", " ?newy "]!" crlf)
	(printout t "[GUESS]--" ?x "|" ?newy crlf)
	(assert (exec (step ?s) (action guess) (x ?x) (y ?newy)))
	(assert (deduced-cell (x ?x) (y ?newy) (content left)));potrebbe anche essere middle
	(pop-focus)
)


;guess sulla cella a sinistra di middle
(defrule guess-middle-left
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	(deduced-cell (x ?x) (y ?y&:(> ?y 0)) (content middle));so che la cella ha contenuto middle e che non è la prima colonna
	(not (k-cell (x ?x) (y ?y1&:(eq ?y1 (- ?y 1)))));non conosco il contenuto della cella a sinistra
	(not (deduced-cell (x ?x) (y ?y1&:(eq ?y1 (- ?y 1)))));non conosco il contenuto della cella a sinistra
	(not (exec  (action guess) (x ?x) (y ?y1&:(eq ?y1 (- ?y 1))))); so che non sono state fatte guess su quella a sinistra
	(not (exec  (action fire) (x ?x) (y ?y1&:(eq ?y1 (- ?y 1))))); so che non sono state fatte fire su quella a sinistra
=>
	(bind ?newy (- ?y 1))
	;(printout t "Fire on cell [" ?x ", " ?newy "]!" crlf)
	(printout t "[GUESS]--" ?x "|" ?newy crlf)
	(assert (exec (step ?s) (action guess) (x ?x) (y ?newy)))
	(assert (deduced-cell (x ?x) (y ?newy) (content left)));potrebbe anche essere middle
	(pop-focus)
)

;guess sulla cella sopra a middle
(defrule guess-over-middle
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	(deduced-cell (x ?x&:(> ?x 0)) (y ?y) (content middle));so che la cella ha contenuto bot e che non è la l'ultima riga
	(not (k-cell (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y)));non conosco il contenuto della cella sopra
	(not (deduced-cell (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y)));non conosco il contenuto della cella sopra
	(not (exec  (action guess) (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y))); so che non sono state fatte guess su quella sopra
	(not (exec  (action fire) (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y))); so che non sono state fatte fire su quella sopra
=>
	(bind ?newx (- ?x 1))
	;(printout t "Fire on cell [" ?newx ", " ?y "]!" crlf)
	(printout t "[GUESS]--" ?newx "|" ?y crlf)
	(assert (exec (step ?s) (action guess) (x ?newx) (y ?y)))
	(assert (deduced-cell (x ?newx) (y ?y) (content top)));potrebbe anche essere middle
	(pop-focus)
)


;random fire
(defrule random-fire-smart
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
	?rand_id <- (try_random_fire)
	(k-per-row (row ?x) (num ?numx&:(> ?numx 0)))
	(k-per-col (col ?y) (num ?numy&:(> ?numy 0)))
	(not (k-cell (x ?x) (y ?y)));non conosco il contenuto della cella
	(not (deduced-cell (x ?x) (y ?y)));non conosco il contenuto della cella
	(not (exec  (action guess) (x ?x) (y ?y))); so che non sono state fatte guess su quella cella
	(not (exec  (action fire) (x ?x) (y ?y))); so che non sono state fatte fire su quella cella
	(not (exec  (action guess) (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y))); so che non sono state fatte guess sulla cella sopra(perchè c'è almeno 1 casella di distanza tra le navi)
	(not (exec  (action fire) (x ?x1&:(eq ?x1 (- ?x 1))) (y ?y))); so che non sono state fatte fire sulla cella sopra(perchè c'è almeno 1 casella di distanza tra le navi)
	(not (exec  (action guess) (x ?x1&:(eq ?x1 (+ ?x 1))) (y ?y))); so che non sono state fatte guess sulla cella sotto(perchè c'è almeno 1 casella di distanza tra le navi)
	(not (exec  (action fire) (x ?x1&:(eq ?x1 (+ ?x 1))) (y ?y))); so che non sono state fatte fire sulla cella sotto(perchè c'è almeno 1 casella di distanza tra le navi)
	(not (exec  (action guess) (x ?x) (y ?y1&:(eq ?y1 (+ ?y 1))))); so che non sono state fatte guess sulla cella a destra(perchè c'è almeno 1 casella di distanza tra le navi)
	(not (exec  (action guess) (x ?x) (y ?y1&:(eq ?y1 (- ?y 1))))); so che non sono state fatte fire sulla cella a sinistra(perchè c'è almeno 1 casella di distanza tra le navi)
=>
	(retract ?rand_id)
	;(printout t "Fire on cell [" ?x ", " ?y "]!" crlf)
	(printout t "[FIRE]--" ?x "|" ?y crlf)
	(assert (exec (step ?s) (action fire) (x ?x) (y ?y)))
	(pop-focus)
)


;-----------------------------------------------------------------------------------------------

;TODO: da rimuovere dopo i primi test
;(defrule inerzia
;	;(declare (salience 10))
;	(status (step ?s)(currently running))
;	(not (exec  (action fire) (x 5) (y 4)) )
;=>
;	(assert (exec (step ?s) (action fire) (x 5) (y 4)))
;    (pop-focus)
;)

(defrule no-more-actions
	(declare (salience -10))
	(status (step ?s)(currently running))
	(moves (fires ?nf &:(> ?nf 0)))
=> 
	(printout t "Trying random cell..." crlf)
	(assert (try_random_fire))
)

(defrule no-more-actions2
	(declare (salience -15))
	(status (step ?s)(currently running))
=> 
	(printout t "I don't know what to do!" crlf)
	(assert (exec (step ?s) (action solve)))
	(pop-focus)
)


;quando ho finito le mie azioni termino
(defrule finish
	(status (step ?s)(currently running))
	(moves (fires 0) (guesses 0))
=>
	(printout t "I have no more fires or guesses. Finished!" crlf)
	(assert (exec (step ?s) (action solve)))
	(pop-focus)
)


