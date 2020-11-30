;   MINESWEEPER AGENT WITH RULE-BASED PROGRAMMING
;   Tugas Besar 2 IF3170 Inteligensi Buatan 2020
;   Developed by:
;   13518004 Qurrata A'yuni
;   13518008 Hasna Roihan Nafiisah
;   13518046 Ferdina Wiranti Afifah
;   13518068 Wildan Zaim Syaddad


; DEFRULE FOR INITIATION AND GAME STATUS
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
            (assert (koordinat ?cnt1 ?cnt2))
            (assert (jumlah-bom-xy ?cnt1 ?cnt2 0))
            (assert (closed ?cnt1 ?cnt2)))))

; Start the game
(defrule start-game
    ?o <- (closed 0 0)
    =>
    (retract ?o)
    (assert (opened 0 0)
    (assert (status playing))
    (assert (flag-found 0))
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
        ;(assert (koordinat ?x ?y))
        (assert (bomb ?x ?y)))
        (assert (jumlah-bom-xy ?x ?y -9999)))

(defrule make-board
    ;update value tiap element disekitar bomb
    (ukuran ?n)
    (bomb ?x ?y)
    (koordinat ?x ?y ?val)
    =>
    (loop-for-count (?cnt 0 ?n) do
        (loop-for-count (?cnt 0 ?n) do
            (if (and (> 2 (- ?x ?cnt)) (> 2 (- ?y ?cnt))) then 
                (+ ?val 1))))
    )
; Win rule: count-flag = amount-bomb -> status Win
(defrule win-game
    (flag-found ?n)
    (amount-bomb ?n)
    ?s <- (status playing)
    =>
    (retract ?s)
    (assert (status win)))

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
    ;(assert (koordinat ?x ?y (+ (1 ?val))))
    (printout t "Bomb di " ?x " " ?y crlf))


; Generate bomb-around (koordinat bombs) after reading bomb coordinates


; DEFRULES WHEN STATUS IS PLAYING
; Open if bomb-around (koordinat 0)
(defrule zero-tiles-East
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x+1 ?y)
    (status playing)
    ?cor <- (closed ?x+1 ?y)
    =>
    (assert (opened ?x+1 ?y))
    (retract ?cor))
(defrule zero-tiles-Southeast
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x+1 ?y-1)
    (status playing)
    ?cor <- (closed ?x+1 ?y-1)
    =>
    (assert (opened ?x+1 ?y-1))
    (retract ?cor))
(defrule zero-tiles-South
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x ?y-1)
    (status playing)
    ?cor <- (closed ?x ?y-1)
    =>
    (assert (opened ?x ?y-1))
    (retract ?cor))
(defrule zero-tiles-Southwest
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x-1 ?y-1)
    (status playing)
    ?cor <- (closed ?x-1 ?y-1)
    =>
    (assert (opened ?x-1 ?y-1))
    (retract ?cor))
(defrule zero-tiles-West
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x-1 ?y)
    (status playing)
    ?cor <- (closed ?x-1 ?y)
    =>
    (assert (opened ?x-1 ?y))
    (retract ?cor))
(defrule zero-tiles-Northwest
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x-1 ?y+1)
    (status playing)
    ?cor <- (closed ?x-1 ?y+1)
    =>
    (assert (opened ?x-1 ?y+1))
    (retract ?cor))
(defrule zero-tiles-North
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x ?y+1)
    (status playing)
    ?cor <- (closed ?x-1 ?y+1)
    =>
    (assert (opened ?x ?y+1))
    (retract ?cor))
(defrule zero-tiles-Northeast
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x+1 ?y+1)
    (status playing)
    ?cor <- (closed ?x+1 ?y+1)
    =>
    (assert (opened ?x+1 ?y+1))
    (retract ?cor))