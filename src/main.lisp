(defpackage :jingle-app/main
  (:use :cl)
  (:import-from :jingle
                :make-app
                :with-request-params
                :with-json-response
                :set-response-status
                :route))
(in-package :jingle-app/main)

(defparameter *app* (make-app))

(defun hello (params)
  (with-request-params ((name "name" "World")) params
    (with-json-response
      `(:|text| ,(format nil "Hello, ~a" name)))))

(setf (route *app* "/hello") #'hello)
