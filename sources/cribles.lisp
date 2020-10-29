;;; MATHTOOLS by C. Agon, M. Andreatta et al.

(in-package :om)

;===============================================

(defclass! sieve () 
  ((cr-exp :initform '(2 0 18) :initarg :cr-exp :accessor cr-exp)
   (maxn :initform 0 :accessor maxn))
  (:icon 423))

;===============================================

(defmethod initialize-instance ((self sieve)  &rest rest)
  (declare (ignore rest))
  (call-next-method)
  (if (not (stringp (car (cr-exp self))))
    (setf (maxn self) (third (cr-exp self)))
    (setf (maxn self) (apply 'max (mapcar 'maxn (cdr (cr-exp self))))))
  self)

;===============================================

(defmethod! s-union ((self sieve) (sieve sieve) &rest rest)
  :doc "It makes the set-theoretical union of two or more sieves/sieves." 
  :icon 423
  (let* ((s-list (append (list self sieve) rest))
         (newc (make-instance 'sieve
                 :cr-exp (cons "sieve-u" s-list))))
    newc ))

;===============================================

(defmethod! s-intersection ((self sieve) (sieve sieve) &rest rest)
  :doc "It makes the set-theoretical intersection of two of more sieves/sieves."
  :icon 423
  (let* ((s-list (append (list self sieve) rest))
         (newc (make-instance 'sieve
                 :cr-exp (cons "sieve-i" s-list))))
    newc))

;===============================================

(defmethod! s-complement ((self sieve))
  :doc "It makes the set-theoretical complement of a sieve/sieve."
  :icon 423
  (let* ((newc (make-instance 'sieve
                 :cr-exp (list "sieve-c" self))))
    newc))
    
;===============================================

(defun sieve-u (&rest rest)
  (let (rep)
    (loop for item in rest do
          (setf rep (union rep item)))
    rep))

;===============================================

(defun sieve-i (&rest rest)
  (let ((rep (car rest)))
    (loop for item in rest do
          (setf rep (intersection rep item)))
    rep))

;===============================================

(defun sieve-c (sieve)
  (let (total)
    (loop for item in rest do
          (setf rep (union rep item)))
    rep))

;===============================================

(defmethod! revel-sieve ((self sieve))
  :doc "It makes visible the sieve object by giving its corresponding residual classes values."
  :icon 423
  (cond

   ((not (stringp (car (cr-exp self))))
    (loop for i from (second (cr-exp self)) to (third (cr-exp self)) by (first (cr-exp self))
          collect i))

   ((string-equal (car (cr-exp self)) "sieve-c")
    (let ((total (loop for i from 0 to (maxn (second (cr-exp self)))  collect i))
    (sieve-r-c (revel-sieve  (second (cr-exp self)))))
    (remove nil (mapcar (lambda (x) (if (om<= (first sieve-r-c) x) x nil)) (sort-list  (set-difference total sieve-r-c))))))

;; Charles K. Neimog = I did one little modification in revel-sieve of sieve-c; it is not beautiful, but work! For me, in this way, it makes more sense musically.

   (t
    (let ((function (intern (string-upcase (car (cr-exp self)))))
          (args (cdr (cr-exp self))))
      (sort (apply function (loop for item in args collect (revel-sieve item))) '<)))
  ))

;===============================================

(defmethod! revel-sieve ((self list))
  (mapcar 'revel-sieve self))

(defmethod! revel-sieve ((self t))
  nil)

(print "sieve, s-union, s-intersection, s-complementation and revel-sieve are objects by Moreno Andreatta and Carlos Agon") 

