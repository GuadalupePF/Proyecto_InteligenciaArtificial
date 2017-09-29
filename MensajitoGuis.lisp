; tablero
(setq tablero
      '(
        (1 0 1 0 1 0 1 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 9 0 0 0 0)
        )
)

; Turno actual
(setq tr 1) 
; Avanzar al gato a la derecha
(defun avanzar-gato-derecha (estado)
  (let
    (
     ; La funcion copy-tree crea una copia pero no liga las variables
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 2 estado))
     (i (nth 0 (nth 1 estado)))
     (j (nth 1 (nth 1 estado)))
     )
    (cond
      (
       (and (and (< i 8) (< j 8)) 
            (and (< (+ i 1) 8) (< (+ j 1) 8)) 
            (= turno 1)
            (= (nth (+ j 1) (nth (+ i 1) tab)) 0)
            (= (nth j (nth i tab)) 1)
            )
       (setf (nth (+ j 1) (nth (+ i 1) tab)) 1)
       (setf (nth j (nth i tab)) 0)
       (list tab (list (+ i 1) (+ j 1)) 9)
       )
      )
    )
  )
; Avanzar gato a la izquierda
(defun avanzar-gato-izquierda (estado)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 2 estado))
     (i (nth 0 (nth 1 estado)))
     (j (nth 1 (nth 1 estado)))
     )
    (cond
      (
       (and (and (< i 8)  (>= j 0))
            (and (< (+ i 1) 8)  (>= (- j 1) 0)) 
            (= turno 1) 
            (= (nth (- j 1) (nth (+ i 1) tab)) 0)
            (= (nth j (nth i tab)) 1)
            )
       
       (setf (nth (- j 1) (nth (+ i 1) tab)) 1)
       (setf (nth j (nth i tab)) 0)
       (list tab (list (+ i 1) (- j 1)) 9)
       )
      )
    )
  )
; Avanzar raton a la derecha
(defun avanzar-raton-derecha (estado)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 2 estado))
     (i (nth 0 (nth 1 estado)))
     (j (nth 1 (nth 1 estado)))
     )
    (cond
      (
       (and (and (>= i 0)  (< j 8))
            (and (>= (- i 1) 0)  (< (+ j 1) 8)) 
            (= turno 9)
            (= (nth (+ j 1) (nth (- i 1) tab)) 0)
            (= (nth j (nth i tab)) 9)
            )
       
       (setf (nth (+ j 1) (nth (- i 1) tab)) 9)
       (setf (nth j (nth i tab)) 0)
       (list tab (list (- i 1) (+ j 1)) 1)
       )
      )
    )
  )
; Avanzar raton a la izquierda
(defun avanzar-raton-izquierda (estado)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 2 estado))
     (i (nth 0 (nth 1 estado)))
     (j (nth 1 (nth 1 estado)))
     )
    (cond
      (
       (and (and (>= i 0)  (>= j 0)) 
            (and (>= (- i 1) 0)  (>= (- j 1) 0)) 
            (= turno 9) 
            (= (nth (- j 1) (nth (- i 1) tab)) 0)
            (= (nth j (nth i tab)) 9)
            )
       
       (setf (nth (- j 1) (nth (- i 1) tab)) 9)
       (setf (nth j (nth i tab)) 0)
       (list tab (list (- i 1) (- j 1)) 1)
       )
      )
    )
  )

; Retroceder raton izquierda
(defun retro-raton-derecha (estado)
  
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 2 estado))
     (i (nth 0 (nth 1 estado)))
     (j (nth 1 (nth 1 estado)))
     )
    (cond
      ; Primera condicion
      (
       ; Comprobacion
       (and (and (< i 8)  (< j 8)) 
            (and (< (+ i 1) 8)  (< (+ j 1) 8)) 
            (= turno 9) 
            (= (nth (+ j 1) (nth (+ i 1) tab)) 0)
            (= (nth j (nth i tab)) 9)
            )
       ; Acciones
       (setf (nth (+ j 1) (nth (+ i 1) tab)) 9)
       (setf (nth j (nth i tab)) 0)
       (list tab (list (+ i 1) (+ j 1)) 1)
       )
      )
    )
  )
; Retroceder raton derecha
(defun retro-raton-izquierda (estado)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 2 estado))
     (i (nth 0 (nth 1 estado)))
     (j (nth 1 (nth 1 estado)))
     )
    (cond
      ; Primera condicion
      (
       ; Comprobacion
       (and (and (< i 8)  (>= j 0)) 
            (and (< (+ i 1) 8) (>= (- j 1) 0)) 
            (= turno 9) 
            (= (nth (- j 1) (nth (+ i 1) tab)) 0)
            (= (nth j (nth i tab)) 9)
            )
       ; Acciones
       (setf (nth (- j 1) (nth (+ i 1) tab)) 9)
       (setf (nth j (nth i tab)) 0)
       (list tab (list (+ i 1) (- j 1)) 1)
       )
      )
    )
  )

(defun vista-jugada (estado)
  (cond 
    ((not estado) "Jugada no valida")
    ((not (not estado)) (imprimir-tablero (nth 0 estado))
     (format t "~&Posicion: ~S" (nth 1 estado))
     (format T "~&Turno: ~S" (NTH 2 ESTADO))  
     )
    )
  )

(defun imprimir-tablero (tablero)
  (dolist (fila tablero)
    (format t "~&~S" fila)
    )
  )

(defun suma-fila (fila)
  ((lambda (sum)
     (mapcar #' (lambda (i) (setq sum (+ sum i))) fila)
     sum
     ) 0)
  )

(defun sumar-filas-adelante (tablero n)
  ((lambda (sum)
     (dotimes (i n) (setq sum (+ sum (suma-fila (nth i tablero)))))
     sum
     ) 0)
  )

(defun pos-raton (tablero)
  ((lambda (x y)
     (dotimes (i 8)
       (dotimes (j 8)
         (cond 
           ((= (nth j (nth i tablero)) 9)
            (setq x i)
            (setq y j)
            )
           )
         )
       )
     (list x y)
     ) 0 0)
  )

(defun raton-encerrado (estado)
  ((lambda (tab i j turno)
     (if (not (and (avanzar-raton-izquierda estado)
                   (avanzar-raton-derecha estado)
                   (retro-raton-izquierda estado)
                   (retro-raton-derecha estado))) t nil)
     ) (copy-tree (nth 0 estado)) (nth 0 (nth 1 estado)) (nth 1 (nth 1 estado)) (nth 2 estado))
  )

(defun test-parada (estado)
  ((lambda (tab i j turno)
     (cond
       ((= turno 9) (if (= (sumar-filas-adelante tab i) 0) "Ha ganado el raton"))
       ((= turno 1) (if (raton-encerrado) "Ha ganado el gato"))
       )
     ) (copy-tree (nth 0 estado)) (nth 0 (nth 1 estado)) (nth 1 (nth 1 estado)) (nth 2 estado))
  )

