;; Functions by Charles K. Neimog (2019 - 2020) | Universidade Federal de Juiz de Fora | charlesneimog.com tes

(in-package :om)

; ==============================================

(defmethod! s-list ((sieve list))
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("Build the sieve class with list of numbers.") 
:icon 423
:doc "Build the sieve class with list of numbers."

(sieve-l-fun sieve))

(defun sieve-l-fun (sieve)  
  (loop for cknloop in sieve :collect (make-value 'sieve (list (list :sieve-exp cknloop)))))

; ==============================================

(defmethod! s-union-l ((sieve list))
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("It does the unions of list of sieves.") 
:icon 423
:doc "It does the unions of list of sieves."

(s-union-l-fun sieve))


(defun s-union-l-fun (sieve) 

(let* (

        (mk-sieve (sieve-l-fun sieve))
  
        (sieve-1 (first mk-sieve))

        (sieve-f (loop :for cknloop :in mk-sieve :collect
        (let* ((accum-fun (lambda (sieve-1 cknloop) (s-union sieve-1 cknloop))))
                  (setf sieve-1 (funcall accum-fun sieve-1 cknloop))))))

(last-elem sieve-f)))

; ==============================================

(defmethod! s-intersection-l ((sieve list))
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("It does the intersections of list of sieves.") 
:icon 423
:doc "It does the intersections of list of sieves."

(s-intersection-l-fun sieve))

(defun s-intersection-l-fun (sieve)
(let* (
  
(mk-sieve (sieve-l-fun sieve))

(sieve-1 (first mk-sieve))

(sieve-f (loop :for cknloop :in mk-sieve :collect
        (let* ((accum-fun #'(lambda (sieve-1 cknloop) (s-intersection sieve-1 cknloop))))
              (setf sieve-1 (funcall accum-fun sieve-1 cknloop))))))

(last-elem sieve-f)))

; ==============================================

(defmethod! s-perfil ((self sieve))

(s-perfil-fun self))


(defun s-perfil-fun (self) (x->dx (revel-sieve self)))

; ======================

(defmethod! s-perfil ((sieve list))
:initvals ' ((23 33 47 63 70))
:indoc ' ("Show the x->dx of some sieve.") 
:icon 423
:doc "Show the x->dx of some sieve."

(x->dx (remove-dup (sort-list sieve))))

; ==============================================

(defmethod! s-decompose ((sieve sieve))
(s-decompose-fun (revel-sieve sieve) (revel-sieve sieve)))

; ==============================================

(defmethod! s-decompose ((sieve list))
:initvals ' ((23 33 47 63 70 71 93 95 119 123 143 153 167 174 183 191 213 215 239 243 263 273 278 287 303 311 333 335 359 363 382 383 393 407 423 431 453 455 479 483 486))
:indoc ' ("It will decompose the result of some sieve") 
:icon 423
:doc "It return the sieves union that will build some set of numbers."

(s-decompose-fun sieve sieve))


;; =====================

(defun s-decompose-fun (sieve original-sieve &optional result)

(let* (

(action1
        (loop :for sieve-element :in sieve :collect 

            (remove nil (let* ( 
                    (last-elem-sieve (last-elem sieve))
                    (flat-sieve (flat original-sieve)))

                    (loop :for cknloop :in flat-sieve :collect 
                        (let* (
                                (box-abs (abs (- sieve-element cknloop)))
                                (box-if (if (= box-abs 0) sieve-element box-abs))
                                (length-of-builded-a-sieve 
                                        (length (remove-duplicates 
                                                (x-append (arithm-ser sieve-element last-elem-sieve box-if)
                                                        flat-sieve)
                                                                :test 'equal))))
                        (if     
                                (= (length original-sieve) length-of-builded-a-sieve)
                                (x-append box-if sieve-element last-elem-sieve) 
                                nil)))))))

(action2 (first (sort-list (flat action1 1) :test '< :key 'second)))
(action3 (let* (
                (one-sieve (arithm-ser (second action2) (third action2) (first action2))))
                        (loop :for cknloop :in one-sieve 
                                :collect
                                (let* ((accum-fun (lambda (sieve cknloop) (remove cknloop sieve))))
                                        (setf sieve (funcall accum-fun sieve cknloop))))))

(action4 (last-elem action3)))

(if (null sieve) 
        (x-append (list action2) result)
        (setf action4 (s-decompose-fun sieve original-sieve (push action2 result))))))

#| Preciso terminar e colocar duas opções para a avaliação da sieve:

        A primeira e analisar a sieve a partir do primeiro número em comum. 
        A segunda e a seguinte: E se houver numeros compartilhados entre duas sieves, como calcular isso?
        |#

; ==============================================
(defmethod! s-symmetry-perfil ((sieve-l LIST) (range list) (modo integer))
:initvals ' ((sieve) (25 500))
:menuins '((2 (("union" 1) ("intersection" 2))))
:indoc ' ("It returns all limites that one sieve will be palimdrome (symmetrical). See Exarchos (2007)." "Range of the limites." "It is union or intersection?") 
:icon 423
:doc " It returns all limites that one sieve will be palimdrome (symmetrical). See Exarchos (2007)."

(let* (
(action1-main (loop :for cknloop :in (arithm-ser (first range) (second range) 1) :collect (let* (
        (box-flat (if (equal modo 1)
                (flat (mapcar (lambda (x) (revel-sieve (s-union-l-fun (mapcar (lambda (sieve-l) (x-append sieve-l x)) sieve-l)))) (list cknloop)))
                (flat (mapcar (lambda (x) (revel-sieve (s-intersection-l-fun (mapcar (lambda (sieve-l) (x-append sieve-l x)) sieve-l)))) (list cknloop)))))   
        (box-x->dx 
                (x->dx (if (om< 3 (length box-flat)) box-flat (list 1 2 4)))))
        (if (equal box-x->dx (reverse box-x->dx))    
        
                (let* (
        (action-1 (loop for cknloop-2 in box-flat :collect  (if (om= cknloop cknloop-2) cknloop-2 nil))))        
        (remove nil action-1)) nil)))))

(flat (remove nil action1-main))))

; ============================================== 

(defmethod! s-limite ((sieve-l LIST) (limite number) (modo integer))
:initvals ' (((19 16) (11 16)) 225)
:indoc ' ("It is possible to change the limit of list of sieves without limites.") 
:menuins '((2 (("union" 1) ("intersection" 2))))
:icon 423
:doc "It is possible to change the limit of list of sieves without limites."

(if (equal modo 1) 
        (s-union-l-fun (mapcar (lambda (x) (x-append x limite)) sieve-l))
        (s-intersection-l-fun (mapcar (lambda (x) (x-append x limite)) sieve-l))))


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
                                        (sieve-class (om::make-value 'sieve (list (list :sieve-exp add-limit)))))
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
                                (first-class-sieve (om::make-value 'sieve (list (list :sieve-exp (x-append sieve-operador sieves)))))
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
:indoc ' ("List with the syntax.") 
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