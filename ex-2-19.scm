;; Exercise 2.19
;;
;; Description:
;;
;; Rewrite the `cc` procedure of the change-counting program from section 1.2.2
;; so that its second argument is a list of the values of the coins to use rather
;; than an integer specifying which coins to use. Define the procedures
;; `first-denomination`, `except-first-denomination`, and `no-more?` in terms
;; of primitive operations on list structures. Does the order of the list
;; `coin-values` affect the answer produced by `cc`? Why or why not?


;; Definitions:

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? coin-values)) 0)
	(else
	 (+ (cc amount 
		(except-first-denomination coin-values))
	    (cc (- amount 
		   (first-denomination coin-values))
		coin-values)))))
;Value: cc

(define (first-denomination coin-values)
  (car coin-values))
;Value: first-denomination

(define (except-first-denomination coin-values)
  (cdr coin-values))
;Value: except-first-denomination

(define (no-more? coin-values)
  (null? coin-values))
;Value: no-more?

(define us-coins (list 50 25 10 5 1))
;Value: us-coins

(define uk-coins (list 100 50 20 10 5 2 1 0.5))
;Value: uk-coins

(define (reverse items)
  (if (null? items)
      items
      (append (reverse (cdr items)) (list (car items)))))
;Value: reverse

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
;Value: append



;; Testing:

(cc 100 us-coins)
;Value: 292

(cc 100 uk-coins)
;Value: 104561

(reverse us-coins)
;Value 14: (1 5 10 25 50)



;; Solution:
;;
;; The ordering of the coins in the list does not affect the output of the
;; `cc` procedure because its implementation does not rely on an implicit
;; ordering of the input list. This is because the process generated by the
;; procedure recursively evaluates each sublist for the full amount after removing
;; the first value in the original list. Concretely the first coin-value in the list
;; will generate a branch calculating the way to change the full amount using
;; all but the first coin-value and a branch calculating the ways to change
;; the amount minus the first coin-value using still all coin-values.
;; Therefore in using different coin-values to begin with, the process does not cause
;; a change in the values returned by the leaf computations of the tree recursion generated.
;; Therefore as these result propogate up the tree and undergo combination the resulting sum
;; will be equal despite the different ordering of the recursive computations.

(cc 100 us-coins)
;Value: 292

(cc 100 (reverse us-coins))
;Value: 292

