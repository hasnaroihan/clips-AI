;   MINESWEEPER AGENT WITH RULE-BASED PROGRAMMING
;   Tugas Besar 2 IF3170 Inteligensi Buatan 2020
;   Developed by:
;   13518004 Qurrata A'yuni
;   13518008 Hasna Roihan Nafiisah
;   13518046 Ferdina Wiranti Afifah
;   13518068 Wildan Zaim Syaddad

; Deftemplates
(deftemplate ukuran
   (slot n
        (type NUMBER)))

(deftemplate koordinat
    (slot x
        (type NUMBER))
    (slot y
        (type NUMBER)))

(deftemplate opened
    (slot koordinat))

(deftemplate closed
    (slot koordinat))

(deftemplate bomb
    (slot koordinat))

; Reading size of board
(defrule reading-n
	=>
	(printout t "Masukkan ukuran board: " )
	(assert (ukuran (n (read)))))

; Reading amount of bomb
(defrule reading-bomb-amount
    =>
    (printout t "Masukkan jumlah bom: ")
    (assert (amount-bomb (read))))

; Reading coordinate of bomb
(defrule reading-coordinate
    (amount-bomb ?nbomb)
	=>
    (loop-for-count (?cnt 0 ?nbomb) do
	    (printout t "Masukkan koordinat x: " )
	    (bind ?x (read))
	    (printout t "Masukkan koordinat y: " )
	    (bind ?y (read))
        (assert (koordinat (x ?x) (y ?y)))
        (assert (bomb (koordinat(x ?x) (y ?y))))))

; Generate board after assert size
(defrule generate-board
    (size ?n)
    =>
    (loop-for-count (?cnt1 0 ?n) do
        (loop-for-count (?cnt2 0 ?n) do
            (assert (koordinat (x ?cnt1) (y ?cnt2)))
            (assert (closed (koordinat (x ?cnt1) (y ?cnt2))))))
    (retract (closed (koordinat (x 0) (y 0))))
    (assert (opened (koordinat (x 0) (y 0)))))
