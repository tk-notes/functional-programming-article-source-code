;; functions as arguments
(defn double-sum
  [a b]
  (* 2 (+ a b)))

(defn double-subtraction
  [a b]
  (* 2 (- a b)))

(defn double-operator
  [f a b]
  (* 2 (f a b)))

(defn even-numbers
  [coll]
  (filter even? coll))

(even-numbers [0 1 2 3 4 5 6 7 8 9 10]) ;; (0 2 4 6 8 10)

;;we have a map of people with name and age.
;; And we want to filter only people over age, meaning people who have more than 21 years old.
(def people [{:name "TK" :age 26}
             {:name "Kaio" :age 10}
             {:name "Kazumi" :age 30}])

(defn over-age
  [people]
  (filter
    #(< 21 (:age %))
    people))
;; ({:name "TK", :age 26} {:name "Kazumi", :age 30})
