(defpackage :jingle-app/main
  (:use :cl)
  (:import-from :jingle
                :make-app
                :install-middleware
                :with-request-params
                :with-json-response
                :set-response-status
                :route)
  (:import-from :dexador)
  (:import-from :jonathan))
(in-package :jingle-app/main)

(defparameter *catfact-endpoint* "https://catfact.ninja/fact")
(defparameter *app* (make-app))

(defun hello (params)
  (with-request-params ((name "name" "World")) params
    (with-json-response
      `(:|text| ,(format nil "Hello, ~a" name)))))

(defun collect-cat-facts (&key counts)
  `(:|facts| ,(loop :repeat counts
                    :collect (getf (jojo:parse (dex:get *catfact-endpoint*))
                                   :|fact|))))

(defun cat (params)
  (declare (ignore params))
  (with-json-response
    (collect-cat-facts :counts 5)))

(setf (route *app* "/hello") #'hello)
(setf (route *app* "/cat") #'cat)
