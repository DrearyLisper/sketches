(defpackage sketches
  (:use #:cl #:sketch)
  (:export :hello))

(in-package :sketches)

(defsketch dvd ((width 1024) (height 576))
  (background +black+)
  (image (load-resource "logo.png") 0 0 160 90))

(make-instance 'dvd)
