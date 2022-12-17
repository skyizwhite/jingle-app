(defpackage #:jingle-app/main
  (:use #:cl)
  (:import-from #:jingle)
  (:import-from #:dexador)
  (:import-from #:jonathan))
(in-package #:jingle-app/main)

(defparameter *catfact-endpoint* "https://catfact.ninja/fact")
(defparameter *app* (jingle:make-app))

(defun hello (params)
  (jingle:with-request-params ((name "name" "World")) params
    (jingle:with-json-response
        (list :|text| (format nil "Hello, ~a" name)))))

(defun collect-cat-facts (&key counts)
  (list :|facts| (loop :repeat counts
                       :collect (getf (jojo:parse (dex:get *catfact-endpoint*))
                                      :|fact|))))

(defun cat (params)
  (declare (ignore params))
  (jingle:with-json-response
    (collect-cat-facts :counts 5)))

(setf (jingle:route *app* "/hello") #'hello)
(setf (jingle:route *app* "/cat") #'cat)
