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

  (setq mode-line-format
	'("%e" (:eval (rabbit/modeline-render)))))

(rabbit/modeline)

(provide 'modeline)
