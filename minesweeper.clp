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
        (type INTEGER)))

(deftemplate koordinat
    (slot x
        (type INTEGER))
    (slot y
        (type INTEGER)))

(deftemplate opened
    (slot koordinat))

(deftemplate closed
    (slot koordinat))

(deftemplate bomb
    (slot koordinat))

(deftemplate bomb-around
    (slot koordinat)
    (slot bombs
        (type INTEGER)))

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
	    (bind ?xs (read))
        ;(assert (x ?xs))
	    (printout t "Masukkan koordinat y: " )
	    (bind ?ys (read))
        ;(assert (y ?ys))
        (assert (koordinat (x ?xs) (y ?ys)))
        (assert (bomb (koordinat (x ?xs) (y ?ys))))))

; Generate board after assert size
(defrule generate-board
    (ukuran (n ?n))
    =>
    (loop-for-count (?cnt1 0 ?n) do
        (loop-for-count (?cnt2 0 ?n) do
            (assert (koordinat (x ?cnt1) (y ?cnt2)))
            (assert (closed (koordinat (x ?cnt1) (y ?cnt2))))))
    (retract (closed (koordinat (x 0) (y 0))))
    (assert (opened (koordinat (x 0) (y 0)))))

; Generate bomb-around (koordinat bombs) after reading bomb coordinates

; Open if bomb-around (koordinat 0)