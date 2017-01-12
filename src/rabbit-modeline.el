(defun rabbit/modeline-buffer-name ()
  ""
  (propertize " %b " 'face '((:foreground "black") (:background "lightgray")))
  )

(defun rabbit/modeline-render ()
  "Render modeline."

  (list (rabbit/modeline-buffer-name))
  )

(defun rabbit/modeline ()
  "Rewrite mode line face."

  (setq-default mode-line-format
	'("%e" (:eval (rabbit/modeline-render)))))


(provide 'rabbit-modeline)
