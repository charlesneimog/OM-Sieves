;; Functions by Charles K. Neimog (2019 - 2020) | Universidade Federal de Juiz de Fora | charlesneimog.com tes

(in-package :om)

; ==============================================

(defmethod! s-list ((sieve list))
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(sieve-l-fun sieve))

(defun sieve-l-fun (sieve)  
  (loop for cknloop in sieve :collect (make-instance 'sieve :sieve-exp cknloop)))

; ==============================================

(defmethod! s-union-l ((sieve list))     ;;n�o funciona
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(let* (
(action1 (s-list sieve))
(action2 (s-union-l-fun action1)))
action2))

; ==============================================

(defun s-union-l-fun (sieves)

(let*  (
    (action1 (s-union (first sieves) (second sieves)))
    (action2 (if 
                (>  (length (flat (list action1))) 2)
                (x-append action1 (last-n sieves (- (length sieves) 2)))
                action1)))
    
    (if (< (length (flat (list action2))) 2)
             action2
            (setf sieves (s-union-l-fun action2)))))

; ==============================================

(defmethod! s-intersection-l ((sieve list))  ;;n�o funciona
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(let* (
(action1 (s-list sieve))
(action2 (s-intersection-l-fun action1)))
action2))

; ==============================================

(defun s-intersection-l-fun (sieves)

(let*  (
    (action1 (s-intersection (first sieves) (second sieves)))
    (action2 (if 
                (>  (length (flat (list action1))) 2)
                (x-append action1 (last-n sieves (- (length sieves) 2)))
                action1)))
    
    (if (< (length (flat (list action2))) 2)
             action2
            (setf sieves (s-intersection-l-fun action2)))))

; ==============================================

(defmethod! s-perfil ((self sieve))
:initvals ' ((23 33 47 63 70 71 93 95 119 123 143 153 167 174 183 191 213 215 239 243 263 273 278 287 303 311 333 335 359 363 382 383 393 407 423 431 453 455 479 483 486))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(s-perfil-fun self))

; ======================


(defun s-perfil-fun (self) (x->dx (revel-sieve self)))

; ==============================================

(defmethod! s-perfil ((sieve cons))  ;;n�o funciona
:initvals ' ((23 33 47 63 70))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(x->dx (remove-dup (sort-list sieve))))

; ==============================================

(defmethod! s-decompose ((sieve list))  
:initvals ' ((23 33 47 63 70 71 93 95 119 123 143 153 167 174 183 191 213 215 239 243 263 273 278 287 303 311 333 335 359 363 382 383 393 407 423 431 453 455 479 483 486))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(s-decompose-fun sieve))

(defun s-decompose-fun (sieve &optional result)

(let* (

(action1
        (loop :for sieve-element :in sieve :collect 

            (remove nil (let* ( 
                    (last-elem-sieve (last-elem sieve))
                    (flat-sieve (flat sieve)))

                    (loop :for cknloop :in flat-sieve :collect 
                        (let* ((box-abs (abs (- sieve-element cknloop)))
                                (box-if (if (= box-abs 0) sieve-element box-abs)))
                                (if     (= (length flat-sieve) (length (remove-duplicates 
                                    (x-append
                                         (arithm-ser sieve-element last-elem-sieve box-if)
                                                flat-sieve)
                                        :test
                                        'equal)))
                                (x-append box-if sieve-element last-elem-sieve) nil)))))))

(action2 (first (sort-list (flat action1 1) :test '< :key 'second)))

(action3 (let* (
(one-sieve (arithm-ser (second action2) (third action2) (first action2))))

(loop :for cknloop :in one-sieve :collect
        (let* ((accum-fun #'(lambda (sieve cknloop) (remove cknloop sieve))))
                  (setf sieve (funcall accum-fun sieve cknloop))))))

(action4 (last-elem action3)))

(if (null sieve) (x-append result (list action2)) (setf action4 (s-decompose-fun sieve (push action2 result))))))

#| Preciso terminar e colocar duas op��es para a avalia��o da sieve:

        A primeira e analisar a sieve a partir do primeiro n�mero em comum. 
        A segunda e a seguinte: E se houver numeros compartilhados entre duas sieves, como calcular isso?
        |#

; ==============================================
(defmethod! s-symmetry-perfil ((sieve-l LIST) (range list) (modo integer))
:initvals ' ((sieve) (25 500) 1)
:menuins '((2 (("union" 1) ("intersection" 2))))
:indoc ' ("List of all the sieves/sieves in questions" "Range of the limites." "It is union or intersection?") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."


(let* (
(action1-main 
 (loop :for cknloop :in (arithm-ser (first range) (second range) 1) :collect 
       (let* (
        (box-flat (if (equal modo 1)
                (flat (mapcar (lambda (x) (revel-sieve (s-union-l (mapcar (lambda (sieve-l) (x-append sieve-l x)) sieve-l)))) (list cknloop)))
                (flat (mapcar (lambda (x) (revel-sieve (s-intersection-l (mapcar (lambda (sieve-l) (x-append sieve-l x)) sieve-l)))) (list cknloop)))))   
        (box-x->dx (x->dx (if (om< 3 (length box-flat)) box-flat (list 1 2 4)))))
        (if (equal box-x->dx (reverse box-x->dx))    
                (let* (
                       (action-1 (loop :for cknloop-2 :in box-flat :collect (if (om= cknloop cknloop-2) cknloop-2 nil))))        
                  (remove nil action-1)) nil)))))

(flat (remove nil action1-main))))

; ============================================== 

(defmethod! s-limite ((sieve-l LIST) (limite number) (modo integer))
:initvals ' (((19 16) (11 16)) 225)
:indoc ' ("List of all the sieves/sieves in questions") 
:menuins '((2 (("union" 1) ("intersection" 2))))
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(if (equal modo 1) 
        (s-union-l-fun (mapcar (lambda (x) (x-append x limite)) sieve-l))
        (s-intersection-l-fun (mapcar (lambda (x) (x-append x limite)) sieve-l))))


; ================================================

;; ==============================================
(defun list-depth (list)
                (if (listp list)
                    (+ 1 (reduce #'max (mapcar #'list-depth list)
                                 :initial-value 0))
                    0))

;; ==============================================

(defun modules-to-sieve (x limit)
        (cond 
                ((and (atom x) (equal (type-of x) 'symbol)) 
                      (if (numberp (search "@" (write-to-string x)))
                          (let* (
                                        (string (om::string-to-list (write-to-string x) "@"))
                                        (make-modules (mapcar (lambda (y) (read-from-string y)) string))
                                        (null-sieve (equal make-modules '(0 0)))
                                        (add-limit (om::x-append make-modules limit))
                                        (sieve-class (rep-editor (apply (quote make-one-instance) (list (make-instance 'sieve nil) add-limit)) 0)))
                                        (if null-sieve nil sieve-class))
                                (cond 
                                        ((equal x 'u) x)
                                        ((equal x 'i) x))))
                
                ((equal (type-of x) 'cons) (remove nil (mapcar (lambda (y) (modules-to-sieve y limit)) x)))))
                

;; ==============================================

(defun mk-sieve-operations (x)
        (if (equal (type-of x) 'cons)
                (if     
                        (not (equal (list-depth x) 1))
                        (mapcar (lambda (y) (mk-sieve-operations y)) x)
                        (let* (
                                (first-sieve (first-n x 3))
                                (sieves (remove-if (lambda (sieve) (or (equal 'u sieve) (equal 'i sieve))) first-sieve))
                                (operadores (remove-if (lambda (sieve) (not (or (equal 'u sieve) (equal 'i sieve)))) first-sieve))
                                (see-if-just-one-operador (remove-dup operadores 'eq 1))
                                (sieve-operador (cond 
                                        ((equal (car see-if-just-one-operador) 'u) "sieve-u")
                                        ((equal (car see-if-just-one-operador) 'i) "sieve-i")))
                                (first-class-sieve (rep-editor (apply (quote make-one-instance) (list (make-instance 'sieve nil) (x-append sieve-operador sieves))) 0))
                                
                                (operator? (if (null sieve-operador) sieves first-class-sieve)))
                                (if 
                                        (null (cdddr x))
                                        operator?
                                        (x-append operator? (cdddr x)))))
                x      
                        ))

;; ==============================================
(defun check-sieves (x)

        (let* (
                (action1 (equal '(t) (remove-dup (mapcar (lambda (list) (or (equal (list-depth list) 0) (equal (list-depth list) 1))) x) 'eq 1)))
                (action2 (om::list! (if action1
                                        (mk-sieve-operations x)
                                        (mapcar (lambda (y) (mk-sieve-operations y)) x)))))
                
                (if 
                        (and (or (equal (list-depth action2) 1) (equal (list-depth action2) 0)) (< (length (flat (om::list! action2))) 3))
                        (car (om::list! (mk-sieve-operations action2)))
                        (check-sieves action2))))

;; ==============================================

(defmethod! s-ariza ((sieve-l list) (limit number))
:initvals ' (((13@70 i 8@70) u (3@33 i 5@33 i 2@33) u (3@23 i 8@23)) 225)
:indoc ' ("List with the syntax." "limit of the sieve") 
:menuins '((2 (("union" 1) ("intersection" 2))))
:icon 423
:doc "It builds sieves using the Ariza (2005) syntax."

(check-sieves (modules-to-sieve sieve-l limit)))

;; ==============================================

(defun sieve-prime-decomposition (n)
  "Return a list of factors of N."
  (when (> n 1)
    (loop with max-d = (isqrt n)
	  for d = 2 then (if (evenp d) (+ d 1) (+ d 2)) do
	  (cond ((> d max-d) (return (list n))) ; n is prime
		((zerop (rem n d)) (return (cons d (sieve-prime-decomposition (truncate n d)))))))))

;; ==============================================

(defun s-prime-decomposition (sieve)
  
(let* (
        (modulo (car sieve))
        (primos (sieve-prime-decomposition modulo))
        (remove-2 (remove-if (lambda (x) (equal 2 x)) primos))
        (non2-modules-decomposed (mapcar (lambda (y) (x-append (read-from-string (string+ (write-to-string y) "@" (write-to-string (second sieve)))) 'i)) remove-2))
        (just-2 (remove-if (lambda (x) (not (equal 2 x))) primos))
        (2-modules-decomposed (string+ (write-to-string (reduce (lambda (a b) (om::om* a b)) just-2)) "@" (write-to-string (second sieve)))))
(x-append (flat non2-modules-decomposed) (read-from-string 2-modules-decomposed))))
             
;; ==============================================
;; ==============================================
;; ==============================================

(defmethod! s-modulus-decomposition ((sieve symbol))
:initvals ' (104@70)
:indoc ' ("Do the decomposition of a non prime modulus") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(s-prime-decomposition (mapcar (lambda (y) (read-from-string y)) (om::string-to-list (write-to-string sieve) "@"))))

;; ==============================================

(defmethod! s-modulus-decomposition ((sieve cons))
:initvals ' (104@70)
:indoc ' ("Do the decomposition of a non prime modulus") 
:icon 423
:doc "It will return the list intersection that produces the modulus."

(loop :for sieve-by-sieve :in sieve :collect (s-modulus-decomposition sieve-by-sieve)))