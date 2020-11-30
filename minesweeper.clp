<<<<<<< HEAD
;   MINESWEEPER AGENT WITH RULE-BASED PROGRAMMING
;   Tugas Besar 2 IF3170 Inteligensi Buatan 2020
;   Developed by:
;   13518004 Qurrata A'yuni
;   13518008 Hasna Roihan Nafiisah
;   13518046 Ferdina Wiranti Afifah
;   13518068 Wildan Zaim Syaddad

=======
(deftemplate ukuran
   (slot n))

(deftemplate koordinat
   (slot x)
   (slot y))

(defrule reading-n
	=>
	(printout t "Masukkan ukuran board: " )
	(assert (n (read))))

(defrule reading-coordinate
	=>
	(printout t "Masukkan koordinat x: " )
	(assert (x (read)))
	(printout t "Masukkan koordinat y: " )
	(assert (y (read))))
>>>>>>> 3acdef05468c2e0f0fa50fe791766252cbb35ca0
