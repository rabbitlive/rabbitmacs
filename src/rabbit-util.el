(provide 'rabbit-util)

(require 's)

(defmacro import (require-name)
  ""
  (let* ((name (symbol-name (cadr require-name)))
	 (fx-name (intern (s-replace "-" "/" name))))
    (list 'progn
	  (list 'require require-name)
	  (list fx-name))))
