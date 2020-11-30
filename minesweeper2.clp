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

; Generate board after assert size
(defrule generate-board
    (ukuran ?n)
    =>
    (loop-for-count (?cnt1 0 ?n) do
        (loop-for-count (?cnt2 0 ?n) do
            (assert (koordinat ?cnt1 ?cnt2 0))
            (assert (closed ?cnt1 ?cnt2)))))

; Start the game
(defrule start-game
    ?o <- (closed 0 0)
    =>
    (retract ?o)
    (assert (opened 0 0))
    )

; Reading amount of bomb
(defrule reading-bomb-amount
    =>
    (printout t "Masukkan jumlah bom: ")
    (assert (amount-bomb (read))))

; Reading coordinate of bomb
(defrule reading-coordinate
    (amount-bomb ?nbomb)
	=>
    (loop-for-count (?cnt 1 ?nbomb) do
	    (printout t "Masukkan koordinat x: " )
	    (bind ?x (read))
	    (printout t "Masukkan koordinat y: " )
	    (bind ?y (read))
        ;(assert (koordinat ?x ?y -9999))
        (assert (bomb ?x ?y))))

(defrule make-board
    (ukuran ?n)
    (bomb ?x ?y)

    =>
    (loop-for-count (?cnt 0 ?n) do
        (loop-for-count (?cnt 0 ?n) do
            (if (or (> 3 (- ?x ?cnt)) (> 3 (- ?y ?cnt))) then 
                )))
    )
; Win rule: count-flag = amount-bomb -> status Win

; Lose rule: (opened x y ) and (bomb x y) -> status Lose
; Assert value of coordinate after generating bomb
(defrule update-value
    (and (koordinat ?x ?y ?val)
         (bomb ?x ?y))
    =>
    ; tambah nilai 1 untuk 8 koordinat disekitarnya
    ; (x-1, y-1) (x-1, y+0) (x-1, y+1)
    ; (x+0, y-1) (x+0, y+0) (x+0, y+1)
    ; (x+1, y-1) (x+1, y+0) (x+1, y+1)
    ; (assert (koordinat ?x ?y (+ (1 ?val))))
    (printout t "Bomb di " ?x " " ?y crlf))


; Generate bomb-around (koordinat bombs) after reading bomb coordinates

; Open if bomb-around (koordinat 0)
