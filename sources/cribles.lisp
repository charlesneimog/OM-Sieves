;;; MATHTOOLS by C. Agon, M. Andreatta et al.

(in-package :om)

;===============================================

(defclass! sieve () 
  ((sieve-exp :initform '(2 0 18) :initarg :sieve-exp :accessor sieve-exp)
   (maxn :initform 0 :accessor maxn))
  (:icon 423))

;===============================================

(defmethod initialize-instance ((self sieve)  &rest rest)
  (declare (ignore rest))
  (call-next-method)
  (if (not (stringp (car (sieve-exp self))))
    (setf (maxn self) (third (sieve-exp self)))
    (setf (maxn self) (apply 'max (mapcar 'maxn (cdr (sieve-exp self))))))
  self)

;===============================================

(defmethod! s-union ((self sieve) (sieve sieve) &rest rest)
  :doc "It makes the set-theoretical union of two or more sieves/sieves." 
  :icon 423
  (let* ((s-list (append (list self sieve) rest))
         (newc (make-instance 'sieve
                 :sieve-exp (cons "sieve-u" s-list))))
    newc ))

;===============================================

(defmethod! s-intersection ((self sieve) (sieve sieve) &rest rest)
  :doc "It makes the set-theoretical intersection of two of more sieves/sieves."
  :icon 423
  (let* ((s-list (append (list self sieve) rest))
         (newc (make-instance 'sieve
                 :sieve-exp (cons "sieve-i" s-list))))
    newc))

;===============================================

(defmethod! s-complement ((self sieve))
  :doc "This object does the complement of a sieve. If we have a sieve from 16 to 32 with the following result (16 19 23 25 28 30 31) with this object, we will obtain all the numbers from 16 to 32 that are not part of the sieve (16 19 23 25 28 30 31). We emphasize that in this object we have changed the implementation of Andreatta and Agon. In their implementation, this object would result, with the same sieve, all numbers from 0 to 32 and not from 16 to 32. In our conception, this lower limit is essential. Because that we changed the implementation so that the s-complement object also considers the lower limit."
  :icon 423
  (let* ((newc (make-instance 'sieve
                 :sieve-exp (list "sieve-c" self))))
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

   ((not (stringp (car (sieve-exp self))))
    (loop for i from (second (sieve-exp self)) to (third (sieve-exp self)) by (first (sieve-exp self))
          collect i))

   ((string-equal (car (sieve-exp self)) "sieve-c")
    (let ((total (loop for i from 0 to (maxn (second (sieve-exp self)))  collect i))
    (sieve-r-c (revel-sieve  (second (sieve-exp self)))))
    (remove nil (mapcar (lambda (x) (if (om<= (first sieve-r-c) x) x nil)) (sort-list  (set-difference total sieve-r-c))))))

;; Charles K. Neimog = I did one little modification in revel-sieve of sieve-c; it is not beautiful, but work! For me, in this way, it makes more sense musically.

   (t
    (let ((function (intern (string-upcase (car (sieve-exp self)))))
          (args (cdr (sieve-exp self))))
      (sort (apply function (loop for item in args collect (revel-sieve item))) '<)))
  ))

;===============================================

(defmethod! revel-sieve ((self list))
  (mapcar 'revel-sieve self))

(defmethod! revel-sieve ((self t))
  nil)

(print "sieve, s-union, s-intersection, s-complementation and revel-sieve are objects by Moreno Andreatta and Carlos Agon")

