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
  (loop for cknloop in sieve :collect (make-value 'sieve (list (list :sieve-exp cknloop)))))

; ==============================================

(defmethod! s-union-l ((sieve list))
:initvals ' (((19 16 64) (11 16 64)))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

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
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

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
:initvals ' ((23 33 47 63 70 71 93 95 119 123 143 153 167 174 183 191 213 215 239 243 263 273 278 287 303 311 333 335 359 363 382 383 393 407 423 431 453 455 479 483 486))
:indoc ' ("List of all the sieves/sieves in questions") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(s-perfil-fun self))


(defun s-perfil-fun (self) (x->dx (revel-sieve self)))

; ======================

(defmethod! s-perfil ((sieve list))
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

#| Preciso terminar e colocar duas opções para a avaliação da sieve:

        A primeira e analisar a sieve a partir do primeiro número em comum. 
        A segunda e a seguinte: E se houver numeros compartilhados entre duas sieves, como calcular isso?
        |#

; ==============================================
(defmethod! s-symmetry-perfil ((sieve-l LIST) (range list) (modo integer))
:initvals ' ((sieve) (25 500))
:menuins '((2 (("union" 1) ("intersection" 2))))
:indoc ' ("List of all the sieves/sieves in questions" "Range of the limites." "It is union or intersection?") 
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."




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
:indoc ' ("List of all the sieves/sieves in questions") 
:menuins '((2 (("union" 1) ("intersection" 2))))
:icon 423
:doc "It converts list of sieves (MODULOS MIN MAX) for midicents notes."

(if (equal modo 1) 
        (s-union-l-fun (mapcar (lambda (x) (x-append x limite)) sieve-l))
        (s-intersection-l-fun (mapcar (lambda (x) (x-append x limite)) sieve-l))))


; ==============================================
(print "sieve, s-union, s-intersection, s-complementation and revel-sieve

                   are objects by 
                   
                   Moreno Andreatta and Carlos Agon")

(print 
 "
                                              OM-Sieves
      by Charles K. Neimog | charlesneimog.com  
   Universidade Federal de Juiz de Fora (2020) 
"
)


