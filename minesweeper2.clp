;   MINESWEEPER AGENT WITH RULE-BASED PROGRAMMING
;   Tugas Besar 2 IF3170 Inteligensi Buatan 2020
;   Developed by:
;   13518004 Qurrata A'yuni
;   13518008 Hasna Roihan Nafiisah
;   13518046 Ferdina Wiranti Afifah
;   13518068 Wildan Zaim Syaddad

; Deftemplates

; Reading size of board
(defrule reading-n
	=>
	(printout t "Masukkan ukuran board: " )
	(assert (ukuran (read))))

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
        (assert (koordinat ?x ?y))
        (assert (bomb ?x ?y))))

; Generate board after assert size
(defrule generate-board
    (ukuran ?n)
    =>
    (loop-for-count (?cnt1 0 ?n) do
        (loop-for-count (?cnt2 0 ?n) do
            (assert (koordinat ?cnt1 ?cnt2))
            (assert (closed (koordinat ?cnt1 ?cnt2)))))
    (retract (closed (koordinat 0 0)))
    (assert (opened (koordinat 0 0))))

; Generate bomb-around (koordinat bombs) after reading bomb coordinates

; Open if bomb-around (koordinat 0)
