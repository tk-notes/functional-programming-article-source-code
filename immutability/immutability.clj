;; immutability

;; in Javascript we commonly use for loop
;; this for statement "for (var i = 0; i < values.length; i++)" has an "i" mutable

(defn sum
  [values]
  (loop [vals values total 0]
    (if (empty? vals)
      total
      (recur (rest vals) (+ (first vals) total)))))

;; handling mutation
(defn slugify
  [string]
  (clojure.string/replace
    (clojure.string/lower-case
      (clojure.string/trim string)) #" " "-"))

(slugify " I will be a url slug   ") ;; "i-will-be-a-url-slug"

;; refactoring with comp function
(defn slugify
  [string]
  ((comp #(clojure.string/replace % #" " "-")
         clojure.string/lower-case
         clojure.string/trim)
         string))

(slugify " I will be a url slug   ") ;; "i-will-be-a-url-slug"
