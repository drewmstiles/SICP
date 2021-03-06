;; Exercise 1.14
;; What are the orders of growth of the space and number of steps used
;; by the count-change procedure of section 1.2.2 as the amount to be
;; changed increases?


;; Definitions.

(define (count-change amount)
  (cc amount 5))
;Value: count-change

;; Recursively computes the ways to count change by reducing problem to
;; the number of ways to compute change for amount without using the
;; first kind of denomation and the number of ways to compute change
;; for amount (a-d) using the denomination where a is the amount and
;; d is the denomination.
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (= kinds-of-coins 0)) 0)
	(else (+ (cc amount 
		     (- kinds-of-coins 1))
		 (cc (- amount 
			(first-denomination kinds-of-coins))
		     kinds-of-coins)))))
;Value: cc

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
	((= kinds-of-coins 2) 5)
	((= kinds-of-coins 3) 10)
	((= kinds-of-coins 4) 25)
	((= kinds-of-coins 5) 50)))
;Value: first-denomination


;; Testing.

(count-change 4)
;Value: 1

(count-change 5)
;Value: 2

(count-change 10)
;Value: 4

(count-change 11)
;Value: 4

(count-change 100)
;Value: 292


;; Solution.

;; Due to the tree-recursive process generated by the `cc` procedure above,
;; the number of computational step increases exponentially as the problem is
;; divided into subproblems. That is, each call to the `cc` procedure generates
;; two subproblems in reponse to the initial problem presented at when the
;; procedure is called. This subproblem proliferation results in the exponential
;; subproblem increase as the problem undergoes decompistion resulting in
;; theta(a^n) computational steps finding the solution. In this case a denotes
;; the amount of change to be calculated whereas n denotes the different types
;; of coin denominations.

;; Conversely the space required for the tree-recursive process in the `cc` procedure
;; experiences only theta(n) spatial growth since the information to be maintained at each
;; subproblem decomposition is equivalent only to the nodes above the current operation at
;; the time of computation.

;; Concretely, subproblem proliferation introduces computational work that increases
;; at an exponential rate for each subproblem, while the number of space required to maintain
;; state for a particular subproblem is equivalent only to the call stack below (above) that
;; particular subproblem.
