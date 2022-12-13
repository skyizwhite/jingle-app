(defsystem "jingle-app"
  :class :package-inferred-system
  :author "skyizwhite"
  :version "0.0.1"
  :description "Playground app using jingle, the web framework for Common Lisp"
  :pathname "src"
  :depends-on (:jingle-app/main))

(register-system-packages "lack-middleware-accesslog" '(:lack.middleware.accesslog))
