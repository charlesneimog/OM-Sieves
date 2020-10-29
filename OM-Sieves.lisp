;;            OM-Sieves
;;
;;      by Carlos Agon, Moreno Andreatta and Charles K. Neimog
;; Universidade Federal de Juiz de Fora (2019-2020)
           
(in-package :om)


(mapc #'(lambda (filename) 
          (compile&load (om-relative-path '("sources") filename))) '("cribles" "OM-Sieves"))


      
(fill-library  '(("Sieve" nil (sieve) (s-union s-intersection s-complement revel-sieve s-decompose s-list s-union-l s-intersection-l s-symmetry-perfil  s-limite) nil)
               
                ))



(print 
 "
                                              OM-Sieves

      Mathtools by Carlos Agon, Moreno Andreatta 
      Others objects by Charles K. Neimog 
      Universidade Federal de Juiz de Fora (2019-2020)
"
)
                    

