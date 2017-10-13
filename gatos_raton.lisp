;tablero
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

(setq tab_gato
      '(
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 1 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 1 0 0 0 1 0)
        (1 0 0 0 0 0 0 9)
        )
)

(setq tab_raton
      '(
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 0 9 0 0 0 0)
        (0 0 1 0 1 0 0 0)
        (0 0 0 0 0 0 0 0)
        (0 0 1 0 0 0 1 0)
        (0 0 0 0 0 0 0 0)
      )
)
; Turno actual
(setq tr 1) 
; Avanzar al gato a la derecha
(defun avanzar-gato-derecha (estado p-ficha-mov)
  (let
    (
     ; La funcion copy-tree crea una copia pero no liga las variables
     (tab (copy-tree (nth 0 estado)))
     ; Se establece el turno del jugador en la variable TURNO
     (turno (nth 1 estado))
     ; Pos i de la ficha
     (i (nth 0 p-ficha-mov))
     ; Pos j de la ficha
     (j (nth 1 p-ficha-mov))
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
       (list tab 9)
       )
      )
    )
  )
; Avanzar gato a la izquierda
(defun avanzar-gato-izquierda (estado p-ficha-mov)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 1 estado))
     (i (nth 0 p-ficha-mov))
     (j (nth 1 p-ficha-mov))
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
       (list tab 9)
       )
      )
    )
  )
; Avanzar raton a la derecha
(defun avanzar-raton-derecha (estado p-ficha-mov)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 1 estado))
     (i (nth 0 p-ficha-mov))
     (j (nth 1 p-ficha-mov))
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
       (list tab 1)
       )
      )
    )
  )
; Avanzar raton a la izquierda
(defun avanzar-raton-izquierda (estado p-ficha-mov)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 1 estado))
     (i (nth 0 p-ficha-mov))
     (j (nth 1 p-ficha-mov))
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
       (list tab 1)
       )
      )
    )
  )

; Retroceder raton izquierda
(defun retro-raton-derecha (estado p-ficha-mov)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 1 estado))
     (i (nth 0 p-ficha-mov))
     (j (nth 1 p-ficha-mov))
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
       (list tab 1)
       )
      )
    )
  )
; Retroceder raton derecha
(defun retro-raton-izquierda (estado p-ficha-mov)
  (let
    (
     (tab (copy-tree (nth 0 estado)))
     (turno (nth 1 estado))
     (i (nth 0 p-ficha-mov))
     (j (nth 1 p-ficha-mov))
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
       (list tab 1)
       )
      )
    )
  )

(defun vista-jugada (estado)
  (cond 
    ((not estado) "Jugada no valida")
    ((not (not estado)) 
     (imprimir-tablero (nth 0 estado))
     (format t "~&Turno: ~S" (nth 1 estado))
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

(defun pos-gatos (tablero)
    ((lambda (pos-gatos)
     (dotimes (i 8)
       (dotimes (j 8)
         (cond 
           ((= (nth j (nth i tablero)) 1)
            (setq pos-gatos (append pos-gatos (list (list i j))))
            )
           )
         )
       )
       pos-gatos
     ) nil)
)

(defun raton-encerrado (estado)
  ((lambda (tab i j turno)
     (if (not (and (avanzar-raton-izquierda estado)
                   (avanzar-raton-derecha estado)
                   (retro-raton-izquierda estado)
                   (retro-raton-derecha estado))) t nil)
     ) (copy-tree (nth 0 estado)) (nth 0 (nth 1 estado)) (nth 1 (nth 1 estado)) (nth 2 estado))
  )
; Si turno es 9 -> T: Ha ganado el raton, NIL: Ha perdido el raton
; Si turno es 1 -> T: Ha ganado el gato , NIL: Ha perdido el gato
(defun test-parada (estado)
  ((lambda (tab turno)
     (cond
       ((= turno 9) (if (= (sumar-filas-adelante tab (nth 0 (pos-raton tab))) 0) t nil))
       ((= turno 1) (if (raton-encerrado estado) t nil))
       )
     ) (copy-tree (nth 0 estado)) (nth 1 estado))
)

(defun gen-sucesores (estado p-ficha-mov)
  (setq sucesores nil)
  (cond
   ((= (nth 1 estado) 9)
    (if (avanzar-raton-izquierda estado p-ficha-mov) 
        (setq sucesores (append sucesores (list (avanzar-raton-izquierda estado p-ficha-mov)))))
    (if (avanzar-raton-derecha estado p-ficha-mov) 
        (setq sucesores (append sucesores (list (avanzar-raton-derecha estado p-ficha-mov)))))
    (if (retro-raton-izquierda estado p-ficha-mov) 
        (setq sucesores (append sucesores (list (retro-raton-izquierda estado p-ficha-mov)))))
    (if (retro-raton-derecha estado p-ficha-mov) 
        (setq sucesores (append sucesores (list (retro-raton-derecha estado p-ficha-mov)))))
   )
   ((= (nth 1 estado) 1)
    (if (avanzar-gato-izquierda estado p-ficha-mov) 
        (setq sucesores (append sucesores (list (avanzar-gato-izquierda estado p-ficha-mov)))))
    (if (avanzar-gato-derecha estado p-ficha-mov) 
        (setq sucesores (append sucesores (list (avanzar-gato-derecha estado p-ficha-mov)))))
    )
   )
  sucesores
)

(defun sucesores-por-turno (estado)
  (let ((lista-sucesores nil))
     (cond 
      ((= (nth 1 estado) 1)
       (dolist (p-gato (pos-gatos (nth 0 estado)))
          (setq lista-sucesores (append lista-sucesores (gen-sucesores estado p-gato)))
       )
      )
      ((= (nth 1 estado) 9)
       (setq lista-sucesores (gen-sucesores estado (pos-raton estado)))
      )
     )
     lista-sucesores
  )
)


(defun mostrar-sucesores (sucesores)
  (mapcar #' (lambda (sucesor) (vista-jugada sucesor)) sucesores)
)

;;;;;;;;;;;
;11/10/17
;;;;;;;;;;;

(defun potencia (x)
 (* x x)
)

(defun distancia (p1 p2)
 (let ((x0 (nth 0 p1)) (y0 (nth 1 p1)) (x1 (nth 0 p2)) (y1 (nth 1 p2)))
  (sqrt (+ (potencia (- x1 x0)) (potencia (- y1 y0))))
 )
)

(defun posicion-evaluacion (p1 p2)
 (if (> (- (nth 0 p2) (nth 0 p1)) 0) 
  1
  -1
 )
)

;Función de Evaluación
;promedio de distancias de los gatos al ratón
(defun evaluacion (tablero)
 (let ((dist-gato-raton 0) (p-raton (pos-raton tablero)))
  (mapcar #' 
   (lambda (p-gato)
    (setq dist-gato-raton (+ dist-gato-raton (* (posicion-evaluacion p-gato p-raton) (distancia p-gato p-raton))))
   )
   (pos-gatos tablero)
  )
 dist-gato-raton
 )
)

(defun evaluar-sucesores (sucesores)
  (mapcar #' 
   (lambda (sucesor)
     (evaluacion (nth 0 sucesor))
   )
   sucesores
  )
)

(defun ordenar-sucesores (sucesores)
  (let ((ltemp nil))
    (mapcar #'
      (lambda (sucesor) 
        (setq ltemp (append ltemp (list (list sucesor (evaluacion (nth 0 sucesor))))))
      )
      sucesores
    )
    (sort ltemp #'> :key #'cadr)
  )
)
;Primero el mejor
(defun primero-el-mejor (estado)
  (let ((sucesores (sucesores-por-turno estado)))
    (caar (ordenar-sucesores sucesores))
  )
)
; Algoritmo MINIMAX
(defun maximo (valores)
  (car (sort valores #'>))
)

(defun minimo (sucesores)
   (car (sort valores #'<))
)

(defun esNodoMIN (nivel)
  (oddp nivel)
)

(defun esNodoMAX (nivel)
  (evenp nivel)
)
(defun minimax (estado nivel)
  ; Caso base
  (let ((valores nil))
    (cond
     ((test-parada estado) 99)
     ((not (test-parada estado)) -99)
     ((= nivel 3) (evaluacion (nth 0 estado)))


     (dolist (sucesor (sucesores-por-turno estado))
       (setq valores (append valores (list (minimax sucesor (+ nivel 1)))))
       (if (esNodoMAX nivel) (maximo valores))
       (if (esNodoMIN nivel) (minimo valores))
       )
     )
  )
)

(defun eleccion-minimax (estado)
  (let ((sucesores (sucesores-por-turno estado)) (ltemp nil))
    (mapcar #'
      (lambda (sucesor) 
        (setq ltemp (append ltemp (list (list sucesor (minimax sucesor 1)))))
      )
      sucesores
    )
    (caar (sort ltemp #'> :key #'cadr))
  )
)