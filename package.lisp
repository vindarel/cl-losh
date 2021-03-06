(defpackage :losh.internal
  (:use :cl))

(in-package :losh.internal)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun external-symbols (package)
    (let ((symbols nil))
      (do-external-symbols (s (find-package package) symbols)
        (push s symbols)))))

(defmacro defpackage-inheriting (name parent-packages &rest args)
  `(defpackage ,name
     ,@args
     ,@(loop :for parent-package :in parent-packages
             :collect `(:use ,parent-package)
             :collect `(:export ,@(external-symbols parent-package)))))


(defpackage :losh.base
  (:export :recursively))


(defpackage :losh.arrays
  (:documentation "Utilities related to arrays.")
  (:export
    :do-array
    :bisect-left
    :bisect-right
    :fill-multidimensional-array
    :fill-multidimensional-array-t
    :fill-multidimensional-array-fixnum
    :fill-multidimensional-array-single-float
    :vector-last))

(defpackage :losh.bits
  (:documentation "Utilities for low-level bit stuff.")
  (:export
    :+/8
    :-/8
    :+/16
    :-/16
    :+/32
    :-/32
    :+/64
    :-/64))

(defpackage :losh.chili-dogs
  (:documentation "Gotta go FAST.")
  (:export
    :defun-inline
    :defun-inlineable))

(defpackage :losh.clos
  (:documentation "Utilities for working with CLOS.")
  (:export
    :defclass*))

(defpackage :losh.control-flow
  (:use :losh.base)
  (:documentation "Utilities for managing control flow.")
  (:export
    :-<>
    :<>
    :nest
    :recursively
    :recur
    :when-found
    :if-found
    :gathering
    :gathering-vector
    :gather
    :if-let
    :if-let*
    :when-let
    :when-let*
    :multiple-value-bind*
    :do-repeat
    :do-range))

(defpackage :losh.debugging
  (:documentation "Utilities for figuring out what the hell is going on.")
  (:export

    #+sbcl :profile
    #+sbcl :start-profiling
    #+sbcl :stop-profiling
    :aesthetic-string
    :bits
    :comment
    :dis
    :gimme
    :hex
    :pht
    :pr
    :print-hash-table
    :print-hash-table-concisely
    :print-table
    :prl
    :shut-up
    :structural-string

    ))

(defpackage :losh.eldritch-horrors
  (:documentation "Abandon all hope, ye who enter here.")
  (:export
    :eval-dammit
    :define-with-macro))

(defpackage :losh.functions
  (:documentation "Utilities for working with higher-order functions.")
  (:export
    :juxt
    :nullary
    :fixed-point))

(defpackage :losh.gnuplot
  (:documentation "Utilities for plotting data with gnuplot.")
  (:export
    :gnuplot
    :gnuplot-args
    :gnuplot-expr
    :gnuplot-function
    :gnuplot-histogram
    :x))

(defpackage :losh.hash-sets
  (:documentation "Simple hash set implementation.")
  (:export
    :hash-set
    :make-hash-set
    :copy-hash-set

    :hset-empty-p
    :hset-contains-p
    :hset-elements
    :hset-count

    :hset-insert!
    :hset-remove!
    :hset-pop!
    :hset-clear!

    :hset=

    :hset-union
    :hset-union!
    :hset-intersection
    :hset-intersection!
    :hset-difference
    :hset-difference!
    :hset-filter
    :hset-filter!
    :hset-map
    :hset-map!
    :hset-reduce))

(defpackage :losh.hash-tables
  (:documentation "Utilities for operating on hash tables.")
  (:export
    :hash-table-contents
    :mutate-hash-values))

(defpackage :losh.io
  (:documentation "Utilities for input/output/reading/etc.")
  (:export
    :read-all-from-file
    :read-all-from-string))

(defpackage :losh.iterate
  (:use :iterate :losh.base) ; need this for iterate's `for` symbol fuckery
  (:documentation "Custom `iterate` drivers and clauses.")
  (:export

    :across-flat-array
    :anding
    :averaging
    :collect-hash
    :cycling
    :every-nth
    :for-nested
    :in-array
    :in-hashset
    :in-lists
    :in-sequences
    :in-whatever
    :index-of-flat-array
    :initially
    :into
    :macroexpand-iterate
    :modulo
    :oring
    :pairs-of-list
    :per-iteration-into
    :real-time
    :recursively
    :run-time
    :since-start-into
    :skip-origin
    :test
    :timing
    :within-radius

    ))

(defpackage :losh.licensing
  (:documentation "Utilities related to open source licenses.")
  (:export
    :print-licenses))

(defpackage :losh.math
  (:documentation "Utilities related to math and numbers.")
  (:export
    :tau
    :tau/2
    :1/2tau
    :tau/4
    :1/4tau
    :2/4tau
    :3/4tau
    :tau/8
    :1/8tau
    :2/8tau
    :3/8tau
    :4/8tau
    :5/8tau
    :6/8tau
    :7/8tau

    :not=
    :clamp
    :degrees
    :dividesp
    :in-range-p
    :lerp
    :map-range
    :norm
    :precise-lerp
    :radians
    :square
    :digit))

(defpackage :losh.mutation
  (:documentation "Utilities for mutating places in-place.")
  (:export
    :zapf
    :%
    :mulf
    :divf
    :modf
    :remainderf
    :clampf
    :negatef
    :notf
    :callf))

(defpackage :losh.priority-queues
  (:documentation "Jankass priority queue implementation.")
  (:export
    :priority-queue
    :make-priority-queue

    :pq-insert
    :pq-ensure
    :pq-dequeue))

(defpackage :losh.queues
  (:documentation "A simple queue implementation.")
  (:export
    :queue
    :make-queue
    :queue-contents
    :queue-size
    :queue-empty-p
    :enqueue
    :dequeue
    :queue-append))

(defpackage :losh.random
  (:documentation "Utilities related to randomness.")
  (:export
    :randomp
    :random-elt
    :random-range
    :random-range-exclusive
    :random-range-inclusive
    :random-around
    :random-gaussian
    :random-gaussian-integer
    :d))

(defpackage :losh.sequences
  (:documentation "Utilities for operating on sequences.")
  (:export
    :extrema
    :enumerate
    :prefix-sums
    :frequencies
    :proportions
    :group-by
    :take
    :take-while
    :drop
    :drop-while
    :summation
    :product))

(defpackage :losh.lists
  (:documentation "Utilities for operating on lists.")
  (:export
    :somelist))

(defpackage :losh.weightlists
  (:documentation
    "A simple data structure for choosing random items with weighted probabilities.")
  (:export
    :weightlist
    :weightlist-weights
    :weightlist-items
    :make-weightlist
    :weightlist-random))


(defpackage-inheriting :losh
  (

   :losh.arrays
   :losh.bits
   :losh.chili-dogs
   :losh.clos
   :losh.control-flow
   :losh.debugging
   :losh.eldritch-horrors
   :losh.functions
   :losh.gnuplot
   :losh.hash-sets
   :losh.hash-tables
   :losh.io
   :losh.iterate
   :losh.licensing
   :losh.lists
   :losh.math
   :losh.mutation
   :losh.priority-queues
   :losh.queues
   :losh.random
   :losh.sequences
   :losh.weightlists

   )
  (:use
    :cl
    :iterate
    :losh.quickutils)
  (:documentation
    "This package exports all of the symbols in the other packages.

  If you just want to get everything you can `:use` this one and be done with
  it.  Otherwise you can `:use` only the ones you need.

  "))


;;;; Remember to add it to the docs!
