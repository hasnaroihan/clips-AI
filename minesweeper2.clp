;   MINESWEEPER AGENT WITH RULE-BASED PROGRAMMING
;   Tugas Besar 2 IF3170 Inteligensi Buatan 2020
;   Developed by:
;   13518004 Qurrata A'yuni
;   13518008 Hasna Roihan Nafiisah
;   13518046 Ferdina Wiranti Afifah
;   13518068 Wildan Zaim Syaddad

; Helper
; East: (koordinat ?x+1 ?y)
; Southeast: (koordinat ?x+1 ?y-1)
; South: (koordinat ?x ?y-1)
; Southwest: (koordinat ?x-1 ?y-1)
; West: (koordinat ?x-1 ?y)
; Northwest: (koordinat ?x-1 ?y+1)
; North: (koordinat ?x ?y+1)
; Northeast: (koordinat ?x+1 ?y+1)

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
            (assert (jumlah-flag-xy ?cnt1 ?cnt2 0))
            (assert (jumlah-closednotflagged ?cnt1 ?cnt2 8))
            (assert (closed ?cnt1 ?cnt2)))))

; Start the game
(defrule start-game
    ?o <- (closed 0 0)
    =>
    (assert (opened 0 0))
    (assert (status playing))
    (assert (flag-found 0))
    (retract ?o)
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
        (assert (bomb ?x ?y))
        (assert (jumlah-bom-xy ?x ?y -9999))))

(defrule make-board
    ;update value tiap element disekitar bomb
    (ukuran ?n)
    (bomb ?x ?y)
    (jumlah-bom-xy ?x ?y ?val)
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
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x+1 ?y))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-Southeast
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x+1 ?y-1)
    (status playing)
    ?cor <- (closed ?x+1 ?y-1)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x+1 ?y-1))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-South
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x ?y-1)
    (status playing)
    ?cor <- (closed ?x ?y-1)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x ?y-1))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-Southwest
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x-1 ?y-1)
    (status playing)
    ?cor <- (closed ?x-1 ?y-1)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x-1 ?y-1))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-West
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x-1 ?y)
    (status playing)
    ?cor <- (closed ?x-1 ?y)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x-1 ?y))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-Northwest
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x-1 ?y+1)
    (status playing)
    ?cor <- (closed ?x-1 ?y+1)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x-1 ?y+1))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-North
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x ?y+1)
    (status playing)
    ?cor <- (closed ?x-1 ?y+1)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x ?y+1))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))
(defrule zero-tiles-Northeast
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y 0)
    (koordinat ?x+1 ?y+1)
    (status playing)
    ?cor <- (closed ?x+1 ?y+1)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val)
    =>
    (assert (opened ?x+1 ?y+1))
    (bind ?val2 (- ?val 1))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val2))
    (retract ?cor))

; increment if flagged
(defrule increment-flag-East
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x+1 ?y)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x+1 ?y ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x+1 ?y ?val2)))
(defrule increment-flag-Southeast
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x+1 ?y-1)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x+1 ?y-1 ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x+1 ?y-1 ?val2)))
(defrule increment-flag-South
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x ?y-1)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x ?y-1 ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x ?y-1 ?val2)))
(defrule increment-flag-Southwest
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x-1 ?y-1)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x-1 ?y-1 ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x-1 ?y-1 ?val2)))
(defrule increment-flag-West
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x-1 ?y)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x-1 ?y ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x-1 ?y ?val2)))
(defrule increment-flag-Northwest
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x-1 ?y+1)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x-1 ?y+1 ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x-1 ?y+1 ?val2)))
(defrule increment-flag-North
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x ?y+1)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x ?y+1 ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x ?y+1 ?val2)))
(defrule increment-flag-Northeast
    (closed ?x ?y)
    (flagged ?x ?y)
    (koordinat ?x+1 ?y+1)
    (status playing)
    ?fl <- (jumlah-flag-xy ?x+1 ?y+1 ?val)
    =>
    (bind ?val2 (+ ?val 1))
    (modify ?fl (jumlah-flag-xy ?x+1 ?y+1 ?val2)))

; flag blank coordinates
(defrule flag-blank-East
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x+1 ?y)
    (closed ?x+1 ?y)
    (not (flagged ?x+1 ?y))
    (status playing)
    =>
    (assert (flagged ?x+1 ?y))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-Southeast
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x+1 ?y-1)
    (closed ?x+1 ?y-1)
    (not (flagged ?x+1 ?y-1))
    (status playing)
    =>
    (assert (flagged ?x+1 ?y-1))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-South
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x ?y-1)
    (closed ?x ?y-1)
    (not (flagged ?x ?y-1))
    (status playing)
    =>
    (assert (flagged ?x ?y-1))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-Southwest
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x-1 ?y-1)
    (closed ?x-1 ?y-1)
    (not (flagged ?x-1 ?y-1))
    (status playing)
    =>
    (assert (flagged ?x-1 ?y-1))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-West
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x-1 ?y)
    (closed ?x-1 ?y)
    (not (flagged ?x-1 ?y))
    (status playing)
    =>
    (assert (flagged ?x-1 ?y))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-Northwest
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x-1 ?y+1)
    (closed ?x-1 ?y+1)
    (not (flagged ?x-1 ?y+1))
    (status playing)
    =>
    (assert (flagged ?x-1 ?y+1))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-North
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x ?y+1)
    (closed ?x ?y+1)
    (not (flagged ?x ?y+1))
    (status playing)
    =>
    (assert (flagged ?x ?y+1))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))

(defrule flag-blank-Northeast
    (opened ?x ?y)
    (jumlah-bom-xy ?x ?y ?val&~0)
    ?cf <- (jumlah-flag-xy ?x ?y ?val2)
    ?cnf <- (jumlah-closednotflagged ?x ?y ?val-?val2)
    ; cek koordinat
    (koordinat ?x+1 ?y+1)
    (closed ?x+1 ?y+1)
    (not (flagged ?x+1 ?y+1))
    (status playing)
    =>
    (assert (flagged ?x+1 ?y+1))
    (bind ?val3 (+ ?val2 1))
    (bind ?val4 (- ?val-?val2 1))
    (modify ?cf (jumlah-flag-xy ?x ?y ?val3))
    (modify ?cnf (jumlah-closednotflagged ?x ?y ?val4)))