;; Exercise 2.42
;;
;; Description:
;;
;; Complete the `queens` procedure defined in the text by implementing the representation
;; for sets of board positions, including the procedures `adjoin-positions`, `empty-board`,
;; and `safe?` which determines whether a queen in the kth column is safe given a set of
;; positions.


;; Definitions:

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
	(list empty-board)
	(filter
	 (lambda (positions) (safe? k positions))
	 (flatmap
	  (lambda (rest-of-queens)
	    (map (lambda (new-row)
		   (adjoin-position new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))
	  (queen-cols (- k 1))))))
  (queen-cols board-size))
;Value: queens


(define (safe? col positions)
  (let ((kth-queen (list-ref positions (- col 1)))
	(other-queens (filter (lambda (q)
				(not (= col (position-col q))))
			      positions)))
    (define (attacks? q1 q2)
      (or (same-row? q1 q2)
	  (same-diagonal? q1 q2)))

    (define (same-row? q1 q2)
      (= (position-row q1) (position-row q2)))
    
    (define (same-diagonal? q1 q2)
      (= (abs (- (position-row q1) (position-row q2)))
	 (abs (- (position-col q1) (position-col q2)))))

    (define (iter q board)
      (or (null? board)
	  (and (not (attacks? q (car board)))
	       (iter q (cdr board)))))
    (iter kth-queen other-queens)))
;Value: safe?

(define (list-ref l n)
  (if (= 0 n)
      (car l)
      (list-ref (cdr l) (- n 1))))
;Value: list-ref





(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))
;Value: flatmap

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
	  (accumulate op initial (cdr seq)))))
;Value: accumulate


(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
;Value: enumerate-interval

(define (make-position row col)
  (cons row col))
;Value: make-position

(define (position-row position)
  (car position))
;Value: position-row

(define (position-col position)
  (cdr position))
;Value: position-col

(define empty-board nil)
;Value: empty-board

(define nil (list ))
;Value: nil

(define (adjoin-position row col positions)
  (append positions (list (make-position row col))))
;Value: adjoin-position

(define (append l1 l2)
  (if (null? l1)
      l2
      (cons (car l1) (append (cdr l1) l2))))
;Value: append


;; Testing:

(append (list 1 2 3) (list 4 5 6)) 
;Value 14: (1 2 3 4 5 6)

; By convention, lists indexed from 0
(list-ref (list 1 2 3 4 5) 3)
;Value: 4

(accumulate + 0 (list 1 2 3))
;Value: 6


;; Solution:

(queens 1)
;Value 15: (((1 . 1)))

(queens 2)
;Value: ()

(queens 3)
;Value: ()

(queens 4)
;Value 17: (((2 . 1) (4 . 2) (1 . 3) (3 . 4)) ((3 . 1) (1 . 2) (4 . 3) (2 . 4)))

(queens 8)
;Value 18: (((1 . 1) (5 . 2) (8 . 3) (6 . 4) (3 . 5) (7 . 6) (2 . 7) (4 . 8)) ((1 . 1) (6 . 2) (8 . 3) (3 . 4) (7 . 5) (4 . 6) (2 . 7) (5 . 8)) ((1 . 1) (7 . 2) (4 . 3) (6 . 4) (8 . 5) (2 . 6) (5 . 7) (3 . 8)) ((1 . 1) (7 . 2) (5 . 3) (8 . 4) (2 . 5) (4 . 6) (6 . 7) (3 . 8)) ((2 . 1) (4 . 2) (6 . 3) (8 . 4) (3 . 5) (1 . 6) (7 . 7) (5 . 8)) ((2 . 1) (5 . 2) (7 . 3) (1 . 4) (3 . 5) (8 . 6) (6 . 7) (4 . 8)) ((2 . 1) (5 . 2) (7 . 3) (4 . 4) (1 . 5) (8 . 6) (6 . 7) (3 . 8)) ((2 . 1) (6 . 2) (1 . 3) (7 . 4) (4 . 5) (8 . 6) (3 . 7) (5 . 8)) ((2 . 1) (6 . 2) (8 . 3) (3 . 4) (1 . 5) (4 . 6) (7 . 7) (5 . 8)) ((2 . 1) (7 . 2) (3 . 3) (6 . 4) (8 . 5) (5 . 6) (1 . 7) (4 . 8)) ((2 . 1) (7 . 2) (5 . 3) (8 . 4) (1 . 5) (4 . 6) (6 . 7) (3 . 8)) ((2 . 1) (8 . 2) (6 . 3) (1 . 4) (3 . 5) (5 . 6) (7 . 7) (4 . 8)) ((3 . 1) (1 . 2) (7 . 3) (5 . 4) (8 . 5) (2 . 6) (4 . 7) (6 . 8)) ((3 . 1) (5 . 2) (2 . 3) (8 . 4) (1 . 5) (7 . 6) (4 . 7) (6 . 8)) ((3 . 1) (5 . 2) (2 . 3) (8 . 4) (6 . 5) (4 . 6) (7 . 7) (1 . 8)) ((3 . 1) (5 . 2) (7 . 3) (1 . 4) (4 . 5) (2 . 6) (8 . 7) (6 . 8)) ((3 . 1) (5 . 2) (8 . 3) (4 . 4) (1 . 5) (7 . 6) (2 . 7) (6 . 8)) ((3 . 1) (6 . 2) (2 . 3) (5 . 4) (8 . 5) (1 . 6) (7 . 7) (4 . 8)) ((3 . 1) (6 . 2) (2 . 3) (7 . 4) (1 . 5) (4 . 6) (8 . 7) (5 . 8)) ((3 . 1) (6 . 2) (2 . 3) (7 . 4) (5 . 5) (1 . 6) (8 . 7) (4 . 8)) ((3 . 1) (6 . 2) (4 . 3) (1 . 4) (8 . 5) (5 . 6) (7 . 7) (2 . 8)) ((3 . 1) (6 . 2) (4 . 3) (2 . 4) (8 . 5) (5 . 6) (7 . 7) (1 . 8)) ((3 . 1) (6 . 2) (8 . 3) (1 . 4) (4 . 5) (7 . 6) (5 . 7) (2 . 8)) ((3 . 1) (6 . 2) (8 . 3) (1 . 4) (5 . 5) (7 . 6) (2 . 7) (4 . 8)) ((3 . 1) (6 . 2) (8 . 3) (2 . 4) (4 . 5) (1 . 6) (7 . 7) (5 . 8)) ((3 . 1) (7 . 2) (2 . 3) (8 . 4) (5 . 5) (1 . 6) (4 . 7) (6 . 8)) ((3 . 1) (7 . 2) (2 . 3) (8 . 4) (6 . 5) (4 . 6) (1 . 7) (5 . 8)) ((3 . 1) (8 . 2) (4 . 3) (7 . 4) (1 . 5) (6 . 6) (2 . 7) (5 . 8)) ((4 . 1) (1 . 2) (5 . 3) (8 . 4) (2 . 5) (7 . 6) (3 . 7) (6 . 8)) ((4 . 1) (1 . 2) (5 . 3) (8 . 4) (6 . 5) (3 . 6) (7 . 7) (2 . 8)) ((4 . 1) (2 . 2) (5 . 3) (8 . 4) (6 . 5) (1 . 6) (3 . 7) (7 . 8)) ((4 . 1) (2 . 2) (7 . 3) (3 . 4) (6 . 5) (8 . 6) (1 . 7) (5 . 8)) ((4 . 1) (2 . 2) (7 . 3) (3 . 4) (6 . 5) (8 . 6) (5 . 7) (1 . 8)) ((4 . 1) (2 . 2) (7 . 3) (5 . 4) (1 . 5) (8 . 6) (6 . 7) (3 . 8)) ((4 . 1) (2 . 2) (8 . 3) (5 . 4) (7 . 5) (1 . 6) (3 . 7) (6 . 8)) ((4 . 1) (2 . 2) (8 . 3) (6 . 4) (1 . 5) (3 . 6) (5 . 7) (7 . 8)) ((4 . 1) (6 . 2) (1 . 3) (5 . 4) (2 . 5) (8 . 6) (3 . 7) (7 . 8)) ((4 . 1) (6 . 2) (8 . 3) (2 . 4) (7 . 5) (1 . 6) (3 . 7) (5 . 8)) ((4 . 1) (6 . 2) (8 . 3) (3 . 4) (1 . 5) (7 . 6) (5 . 7) (2 . 8)) ((4 . 1) (7 . 2) (1 . 3) (8 . 4) (5 . 5) (2 . 6) (6 . 7) (3 . 8)) ((4 . 1) (7 . 2) (3 . 3) (8 . 4) (2 . 5) (5 . 6) (1 . 7) (6 . 8)) ((4 . 1) (7 . 2) (5 . 3) (2 . 4) (6 . 5) (1 . 6) (3 . 7) (8 . 8)) ((4 . 1) (7 . 2) (5 . 3) (3 . 4) (1 . 5) (6 . 6) (8 . 7) (2 . 8)) ((4 . 1) (8 . 2) (1 . 3) (3 . 4) (6 . 5) (2 . 6) (7 . 7) (5 . 8)) ((4 . 1) (8 . 2) (1 . 3) (5 . 4) (7 . 5) (2 . 6) (6 . 7) (3 . 8)) ((4 . 1) (8 . 2) (5 . 3) (3 . 4) (1 . 5) (7 . 6) (2 . 7) (6 . 8)) ((5 . 1) (1 . 2) (4 . 3) (6 . 4) (8 . 5) (2 . 6) (7 . 7) (3 . 8)) ((5 . 1) (1 . 2) (8 . 3) (4 . 4) (2 . 5) (7 . 6) (3 . 7) (6 . 8)) ((5 . 1) (1 . 2) (8 . 3) (6 . 4) (3 . 5) (7 . 6) (2 . 7) (4 . 8)) ((5 . 1) (2 . 2) (4 . 3) (6 . 4) (8 . 5) (3 . 6) (1 . 7) (7 . 8)) ((5 . 1) (2 . 2) (4 . 3) (7 . 4) (3 . 5) (8 . 6) (6 . 7) (1 . 8)) ((5 . 1) (2 . 2) (6 . 3) (1 . 4) (7 . 5) (4 . 6) (8 . 7) (3 . 8)) ((5 . 1) (2 . 2) (8 . 3) (1 . 4) (4 . 5) (7 . 6) (3 . 7) (6 . 8)) ((5 . 1) (3 . 2) (1 . 3) (6 . 4) (8 . 5) (2 . 6) (4 . 7) (7 . 8)) ((5 . 1) (3 . 2) (1 . 3) (7 . 4) (2 . 5) (8 . 6) (6 . 7) (4 . 8)) ((5 . 1) (3 . 2) (8 . 3) (4 . 4) (7 . 5) (1 . 6) (6 . 7) (2 . 8)) ((5 . 1) (7 . 2) (1 . 3) (3 . 4) (8 . 5) (6 . 6) (4 . 7) (2 . 8)) ((5 . 1) (7 . 2) (1 . 3) (4 . 4) (2 . 5) (8 . 6) (6 . 7) (3 . 8)) ((5 . 1) (7 . 2) (2 . 3) (4 . 4) (8 . 5) (1 . 6) (3 . 7) (6 . 8)) ((5 . 1) (7 . 2) (2 . 3) (6 . 4) (3 . 5) (1 . 6) (4 . 7) (8 . 8)) ((5 . 1) (7 . 2) (2 . 3) (6 . 4) (3 . 5) (1 . 6) (8 . 7) (4 . 8)) ((5 . 1) (7 . 2) (4 . 3) (1 . 4) (3 . 5) (8 . 6) (6 . 7) (2 . 8)) ((5 . 1) (8 . 2) (4 . 3) (1 . 4) (3 . 5) (6 . 6) (2 . 7) (7 . 8)) ((5 . 1) (8 . 2) (4 . 3) (1 . 4) (7 . 5) (2 . 6) (6 . 7) (3 . 8)) ((6 . 1) (1 . 2) (5 . 3) (2 . 4) (8 . 5) (3 . 6) (7 . 7) (4 . 8)) ((6 . 1) (2 . 2) (7 . 3) (1 . 4) (3 . 5) (5 . 6) (8 . 7) (4 . 8)) ((6 . 1) (2 . 2) (7 . 3) (1 . 4) (4 . 5) (8 . 6) (5 . 7) (3 . 8)) ((6 . 1) (3 . 2) (1 . 3) (7 . 4) (5 . 5) (8 . 6) (2 . 7) (4 . 8)) ((6 . 1) (3 . 2) (1 . 3) (8 . 4) (4 . 5) (2 . 6) (7 . 7) (5 . 8)) ((6 . 1) (3 . 2) (1 . 3) (8 . 4) (5 . 5) (2 . 6) (4 . 7) (7 . 8)) ((6 . 1) (3 . 2) (5 . 3) (7 . 4) (1 . 5) (4 . 6) (2 . 7) (8 . 8)) ((6 . 1) (3 . 2) (5 . 3) (8 . 4) (1 . 5) (4 . 6) (2 . 7) (7 . 8)) ((6 . 1) (3 . 2) (7 . 3) (2 . 4) (4 . 5) (8 . 6) (1 . 7) (5 . 8)) ((6 . 1) (3 . 2) (7 . 3) (2 . 4) (8 . 5) (5 . 6) (1 . 7) (4 . 8)) ((6 . 1) (3 . 2) (7 . 3) (4 . 4) (1 . 5) (8 . 6) (2 . 7) (5 . 8)) ((6 . 1) (4 . 2) (1 . 3) (5 . 4) (8 . 5) (2 . 6) (7 . 7) (3 . 8)) ((6 . 1) (4 . 2) (2 . 3) (8 . 4) (5 . 5) (7 . 6) (1 . 7) (3 . 8)) ((6 . 1) (4 . 2) (7 . 3) (1 . 4) (3 . 5) (5 . 6) (2 . 7) (8 . 8)) ((6 . 1) (4 . 2) (7 . 3) (1 . 4) (8 . 5) (2 . 6) (5 . 7) (3 . 8)) ((6 . 1) (8 . 2) (2 . 3) (4 . 4) (1 . 5) (7 . 6) (5 . 7) (3 . 8)) ((7 . 1) (1 . 2) (3 . 3) (8 . 4) (6 . 5) (4 . 6) (2 . 7) (5 . 8)) ((7 . 1) (2 . 2) (4 . 3) (1 . 4) (8 . 5) (5 . 6) (3 . 7) (6 . 8)) ((7 . 1) (2 . 2) (6 . 3) (3 . 4) (1 . 5) (4 . 6) (8 . 7) (5 . 8)) ((7 . 1) (3 . 2) (1 . 3) (6 . 4) (8 . 5) (5 . 6) (2 . 7) (4 . 8)) ((7 . 1) (3 . 2) (8 . 3) (2 . 4) (5 . 5) (1 . 6) (6 . 7) (4 . 8)) ((7 . 1) (4 . 2) (2 . 3) (5 . 4) (8 . 5) (1 . 6) (3 . 7) (6 . 8)) ((7 . 1) (4 . 2) (2 . 3) (8 . 4) (6 . 5) (1 . 6) (3 . 7) (5 . 8)) ((7 . 1) (5 . 2) (3 . 3) (1 . 4) (6 . 5) (8 . 6) (2 . 7) (4 . 8)) ((8 . 1) (2 . 2) (4 . 3) (1 . 4) (7 . 5) (5 . 6) (3 . 7) (6 . 8)) ((8 . 1) (2 . 2) (5 . 3) (3 . 4) (1 . 5) (7 . 6) (4 . 7) (6 . 8)) ((8 . 1) (3 . 2) (1 . 3) (6 . 4) (2 . 5) (5 . 6) (7 . 7) (4 . 8)) ((8 . 1) (4 . 2) (1 . 3) (3 . 4) (6 . 5) (2 . 6) (7 . 7) (5 . 8)))


;; Notes:
;;
;; Based on the solution by Bill the Lizard.
;; http://www.billthelizard.com/2011/06/sicp-242-243-n-queens-problem.html