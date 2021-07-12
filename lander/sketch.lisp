(defpackage sketches
  (:use #:cl #:sketch)
  (:export :sketch))

(in-package :sketches)

(defsketch lander (
                   (width 1024)
                   (height 576)
                   (x 0) (y 0)
                   (dx 3) (dy 2)
                   (logo-width 80) (logo-height 80))
  (background (rgb-255 173 98 66))
  (with-pen (make-pen :fill +black+)
    (image (load-resource "lander.png") x y logo-width logo-height))
  (setf x (+ x dx))
  (setf y (+ y dy))
  (when (or (<= x 0) (>= x (- width logo-width)))
    (setf dx (- dx)))
  (when (or (<= y 0) (>= y (- height logo-height)))
    (setf dy (- dy)))
  )

(make-instance 'lander)
