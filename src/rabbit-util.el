(provide 'rabbit-util)

(require 's)

;; import
(defun rabbit/replace-import-namt-str (str)
  "Convert foo-bar to foo/bar"
  (s-replace "-" "/" str))

(defmacro import (require-name)
  ""
  (let* ((name (symbol-name (cadr require-name)))
	 (fx-name (intern (rabbit/replace-import-namt-str name))))
    (list 'progn
	  (list 'require require-name)
	  (list fx-name))))

;; yas/emacs-lisp-mode
(defun rabbit/buffer-name-base ()
  "Buffer name base."
  (interactive)
  (f-base (buffer-name)))

(defun rabbit/replace-import-name ()
  "Used by yas."
  (interactive)
  (rabbit/replace-import-namt-str (rabbit/buffer-name-base)))


;; render to buffer
(defun rabbit/render-to-buffer (name &optional body)
  "Push buffer content."
  (with-current-buffer (get-buffer-create name)
    (erase-buffer)
    (insert body)
    (pop-to-buffer (current-buffer))))


;; global store
(defun rabbit/store-register (key &optional value)
  "Global store register."
  (setq rabbit/store
	(plist-put rabbit/store key value)))


(defun rabbit/store-selector (key)
  "Pick store."
  (plist-get rabbit/store key))
