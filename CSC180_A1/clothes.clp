(defrule p1
	?p <- (start)
	=>
	(printout t "Please type 'yes' or 'no' to the following questions: " crlf)
	(printout t "Are you attending a formal event? " crlf)
	(assert (formal (read)))
	(printout t "" crlf)
	(retract ?p)
)

(defrule p2
	(formal yes)
	=>
	(printout t "Are you feeling feminine? " crlf)
	(assert (feminine (read)))
	(printout t "" crlf)
)

(defrule result1
	(formal yes)
	(feminine yes)
	=>
	(printout t "You should wear a nice dress with formal shoes today. " crlf)
)

(defrule result2
	(formal yes)
	(feminine no)
	=>
	(printout t "You should wear a suit with formal shoes today. " crlf)
)

(defrule p3
	(formal no)
	=>
	(printout t "Are you going to be mostly indoors today? " crlf)
	(assert (indoors (read)))
	(printout t "" crlf)
)

(defrule p4
	(formal no)
	(indoors yes)
	=>
	(printout t "Is it cold, even inside? " crlf)
	(assert (coldin (read)))
	(printout t "" crlf)
)

(defrule result3
	(indoors yes)
	(coldin yes)
	=>
	(printout t "You should wear a long sleeve shirt, long pants, and good shoes. " crlf)
)

(defrule result4
	(indoors yes)
	(coldin no)
	=>
	(printout t "You should wear a short sleeve shirt and good shoes. If it's still too warm for you, wear shorts. " crlf)
)

(defrule p5
	(formal no)
	(indoors no)
	=>
	(printout t "Is it cold outside? " crlf)
	(assert (coldout (read)))
	(printout t "" crlf)
)

(defrule p6
	(indoors no)
	(coldout yes)
	=>
	(printout t "Is it raining? " crlf)
	(assert (raining (read)))
	(printout t "" crlf)
)

(defrule result5
	(coldout yes)
	(raining yes)
	=>
	(printout t "You should wear a raincoat and rainboots. Sturdy, long pants would also be ideal. " crlf)
)

(defrule result6
	(coldout yes)
	(raining no)
	=>
	(printout t "You should wear a windbreaker, long pants, and some good shoes. " crlf)
)

(defrule p7
	(indoors no)
	(coldout no)
	=>
	(printout t "Will you be very active today? " crlf)
	(assert (active (read)))
	(printout t "" crlf)
)

(defrule result7
	(coldout no)
	(active no)
	=>
	(printout t "You should wear short sleeves. Any shoes and pants will do, even sandals and shorts! " crlf)
)

(defrule result8
	(coldout no)
	(active yes)
	=>
	(printout t "You should wear short sleeves, shorts, and running shoes. " crlf)
)

(deffacts startup
	(start)
)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	