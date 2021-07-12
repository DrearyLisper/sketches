(defpackage sketches
  (:use #:cl #:sketch)
  (:export :hello))

(in-package :sketches)

(defsketch dvd ((width 1024) (height 576) (x 0) (y 0) (dx 3) (dy 2) (logo-width 160) (logo-height 90))
  (background +black+)
  (image (load-resource "logo.png") x y logo-width logo-height)
  (setf x (+ x dx))
  (setf y (+ y dy))
  (when (or (<= x 0) (>= x (- width logo-width)))
    (setf dx (- dx)))
  (when (or (<= y 0) (>= y (- height logo-height)))
    (setf dy (- dy)))
  )

(make-instance 'dvd)
