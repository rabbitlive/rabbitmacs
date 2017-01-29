;; -*- mode: emacs-lisp -*-
;; -*- coding: utf-8 -*-

(provide 'rabbit-snippets)

(defun rabbit/snippets ()
  "Configure yasnippet."
  (require 'yasnippet)
  (require 'f)
  (add-to-list 'yas-snippet-dirs
	       (f-join (f-dirname (f-this-file)) "../snippets"))
  (yas-global-mode 1)
  (global-set-key (kbd "C-'") 'yas-reload-all))

