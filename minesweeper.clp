(deftemplate ukuran
   (slot n))

(deftemplate koordinat
   (slot x)
   (slot y))

(defrule reading-coordinate
	=>
	(printout t "Masukkan koordinat x: " )
	(assert (x (read)))
	(printout t "Masukkan koordinat y: " )
	(assert (y (read))))

(defrule reading-n
	=>
	(printout t "Masukkan ukuran board: " )
	(assert (n (read))))