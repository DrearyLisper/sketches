(defpackage sketches
  (:use #:cl #:sketch)
  (:export :sketch))

(in-package :sketches)


(defclass lander-sprite ()
  ((x
    :initform 0
    :accessor x)
   (y
    :initform 0
    :accessor y)
   (vx
    :initform 0
    :accessor vx)
   (vy
    :initform 0
    :accessor vy)
   (ax
    :initform 0.015
    :accessor ax)
   (ay
    :initform 0.03721
    :accessor ay)
   (width
    :initform 80
    :accessor width)
   (height
    :initform 80
    :accessor height)
   (is-crashed
    :initform nil
    :accessor is-crashed)
   (sprite-filename
    :initform "lander.png"
    :accessor sprite-filename)
   ))

(defparameter lander-obj (make-instance 'lander-sprite))
(defparameter screen-width 1024)
(defparameter screen-height 576)

(defgeneric draw-lander (obj))
(defmethod draw-lander ((obj lander-sprite))
  (with-pen (make-pen :fill +black+)
    (image
     (load-resource (sprite-filename obj))
     (x obj)
     (y obj)
     (width obj)
     (height obj))
    (text (write-to-string (vy obj)) 0 0)
    )
  )

(defgeneric in-collision? (obj))
(defmethod in-collision? ((obj lander-sprite))
   (or (< (x obj) 0) (>= (x obj) (- screen-width (width obj)))
       (< (y obj) 0) (>= (y obj) (- screen-height (height obj))))
  )

(defgeneric update-lander (obj))
(defmethod update-lander ((obj lander-sprite))
  (when (not (is-crashed obj))
    (incf (x obj) (vx obj))
    (incf (y obj) (vy obj))
    (incf (vx obj) (ax obj))
    (incf (vy obj) (ay obj))
    )
  (when (in-collision? obj)
    (when (>= (vy obj) 0.055)
      (setf (is-crashed obj) T)
      (setf (sprite-filename obj) "fire.png"))
    )
  )

(defsketch lander ((width screen-width) (height screen-height))
  (background (rgb-255 173 98 66))
  (draw-lander lander-obj)
  (update-lander lander-obj)
  )

(defmethod setup ((lander-sketch lander) &key &allow-other-keys)
  (setf (x lander-obj) (/ (- screen-width (width lander-obj)) 2)))

(make-instance 'lander)
