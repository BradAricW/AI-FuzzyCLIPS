;;get inputs
(defrule GetInputs
	?i <- (initial-fact)
	=>
	(printout t "What type of pipe is it" crlf)
	(assert (type (read)))
	(printout t "" crlf)
	
	(printout t "What is the diameter of the pipe?" crlf)
	(assert (diameter-factor (read)))
	(printout t "" crlf)
	
	(printout t "What is the temperature of the gas?" crlf)
	(assert (temp-input (read)))
	(printout t "" crlf)
	
	(printout t "Enter the number of Human Occupency Dwellings " crlf)
	(printout t "(Note: Count apartments as individual dwellings): " crlf)
	(bind ?response (read))
	(assert (crispHOD ?response))
	(printout t "" crlf)
	
	(printout t "Enter the number of people regularly occupying nearby Public Gathering Areas: " crlf)
	(bind ?response (read))
	(assert (crispPGA ?response))
	(printout t "" crlf)
	
	(printout t "Enter the number of high rises in the zone: " crlf)
	(bind ?response (read))
	(assert (crispHR ?response))
	(printout t "" crlf)
	
	(retract ?i)
)

;;fuzzify inputs 
(defrule Fuzzify
	(crispHOD ?h)
	(crispPGA ?p)
	(crispHR ?k)
	=>
	(assert (HOD (?h 0) (?h 1) (?h 0)))
	(assert (PGA (?p 0) (?p 1) (?p 0)))
	(assert (HR (?k 0) (?k 1) (?k 0)))
)

;; Fuzzy Inputs
(deftemplate HOD
	0 50 dwellings
	((Class1 (8 1) (10 0))
	 (Class2 (8 0) (10 1) (36 1) (46 0))
	 (Class3 (36 0) (46 1))
	)
)

(deftemplate PGA
	0 30 people
	((NC1 (15 1) (20 0))
	 (Change1 (15 0) (20 1))
	)
)

(deftemplate HR
	0 75 high-rises
	((NC2 (30 1) (45 0))
	 (Change2 (30 0) (45 1))
	)
)

;; Fuzzy Outputs
(deftemplate PCR
	0 4 classification1
	((PCR1 (1.75 1) (2 0))
	 (PCR2 (1.75 0) (2 1) (2.75 1) (3 0))
	 (PCR3 (2.75 0) (3 1))
	)
)

(deftemplate Final
	0 5 classification2
	((Final1 (1.75 1) (2 0))
	 (Final2 (1.75 0) (2 1) (2.75 1) (3 0))
	 (Final3 (2.75 0) (3 1) (3.75 1) (4 0))
	 (Final4 (3.75 0) (4 1))
	)
)

;; FAM 1 rules
(defrule F1NC1
	(HOD Class1)
	(PGA NC1)
	=>
	(assert (PCR PCR1))
)

(defrule F1NC2
	(HOD Class2)
	(PGA NC1)
	=>
	(assert (PCR PCR2))
)

(defrule F1NC3
	(HOD Class3)
	(PGA NC1)
	=>
	(assert (PCR PCR3))
)

(defrule F1C1
	(HOD Class1)
	(PGA Change1)
	=>
	(assert (PCR PCR2))
)

(defrule F1C2
	(HOD Class2)
	(PGA Change1)
	=>
	(assert (PCR PCR3))
)

(defrule F1C3
	(HOD Class3)
	(PGA Change1)
	=>
	(assert (PCR PCR3))
)

;; FAM 2 rules
(defrule F2NC1
	(PCR PCR1)
	(HR NC2)
	=>
	(assert (Final Final1))
)

(defrule F2NC2
	(PCR PCR2)
	(HR NC2)
	=>
	(assert (Final Final2))
)

(defrule F2NC3
	(PCR PCR3)
	(HR NC2)
	=>
	(assert (Final Final3))
)

(defrule F2C1
	(PCR PCR1)
	(HR Change2)
	=>
	(assert (Final Final4))
)

(defrule F2C2
	(PCR PCR2)
	(HR Change2)
	=>
	(assert (Final Final4))
)

(defrule F2C3
	(PCR PCR3)
	(HR Change2)
	=>
	(assert (Final Final4))
)

;; defuzzify outputs
(defrule Defuzzify1
	(declare (salience -1))
	?f <- (Final ?)
	=>
	(bind ?t (moment-defuzzify ?f))
	(assert (class-output ?t))
)

(defrule classificationRule1
	(class-output ?x)
	(test (< ?x 2))
	=>
	(assert (class-factor 0.72))
	(printout t "Classification is 1" crlf)
)

(defrule classificationRule2
	(class-output ?x)
	(test (>= ?x 2))
	(test (< ?x 3))
	=>
	(assert (class-factor 0.60))
	(printout t "Classification is 2" crlf)
)

(defrule classificationRule3
	(class-output ?x)
	(test (>= ?x 3))
	(test (< ?x 4))
	=>
	(assert (class-factor 0.50))
	(printout t "Classification is 3" crlf)
)

(defrule classificationRule4
	(class-output ?x)
	(test (>= ?x 4))
	=>
	(assert (class-factor 0.40))
	(printout t "Classification is 4" crlf)
)

(defrule crispRule1
	(temp-input ?x)
	(test (< ?x 300))
	=>
	(assert (temp-factor 1))
)

(defrule crispRule2
	(temp-input ?x)
	(test (>= ?x 300))
	(test (< ?x 350))
	=>
	(assert (temp-factor 0.967))
)

(defrule crispRule3
	(temp-input ?x)
	(test (>= ?x 350))
	(test (< ?x 400))
	=>
	(assert (temp-factor 0.933))
)

(defrule crispRule4
	(temp-input ?x)
	(test (>= ?x 400))
	(test (< ?x 450))
	=>
	(assert (temp-factor 0.900))
)

(defrule crispRule5
	(temp-input ?x)
	(test (= ?x 450))
	=>
	(assert (temp-factor 0.867))
)

(defrule crispRule6
	(type line)
	=>
	(assert (pipe-factor 5325))
)

(defrule crispRule7
	(type zinc-coated)
	=>
	(assert (pipe-factor 8875))
)

(defrule crispRule8
	(type carbon)
	=>
	(assert (pipe-factor 8875))
)

(defrule crispRule9
	(type welded)
	=>
	(assert (pipe-factor 10650))
)

(defrule crispRule10
	(type metal-arc-welded)
	=>
	(assert (pipe-factor 11360))
)

(defrule crispRule11
	(type electric-fusion-welded)
	=>
	(assert (pipe-factor 12425))
)

(defrule crispRule12
	(type carbon and alloy)
	=>
	(assert (pipe-factor 7810))
)

(defrule crispRule13
	(pipe-factor ?x)
	(diameter-factor ?y)
	(temp-factor ?z)
	(class-factor ?w)
	=>
	(assert (results (*(* (/ ?x ?y) ?z)?w)))
)

(defrule crispResult
	(results ?r)
	=>
	(printout t "MAOP is " ?r crlf)
)



(deffacts startup
	(initial-fact)
)